import bottle
import model
from datetime import datetime

SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()
STANJE = "stanje.json"
vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)


# V primeru, da uporabnik izbirše piškotek, ga to preusmeri začetno stran
def stanje_trenutnega_uporabnika():
    uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime')
    if uporabnisko_ime is None:
        bottle.redirect('/')
            

@bottle.get('/')
def index():
    bottle.response.delete_cookie("barva", path = "/igraj_proti_racunalniku/", secret=SKRIVNOST)
    return bottle.template("views/osnova.tpl")

@bottle.route('/static/<ime_dat:path>')
def server_static(ime_dat):
  pot = 'static'
  return bottle.static_file(ime_dat, root=pot)

@bottle.get("/statistika/")
def arhiv_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("statistika.tpl")

@bottle.get("/arhiv/")
def arhiv_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("arhiv.tpl")

@bottle.get("/arhiv/<id:path>")
def server_static(id):
    stanje_trenutnega_uporabnika()
    return bottle.template("arhiv_igra.tpl", id=id[:-1])

@bottle.post('/igraj_proti_racunalniku/stanley/<barva:path>')
def server_static(barva):
    stanje_trenutnega_uporabnika()
    pot = '/igraj_proti_racunalniku/'
    bottle.response.set_cookie("barva", barva[:-1], path=pot, max_age=1, secret=SKRIVNOST)
    bottle.redirect("/igraj_proti_racunalniku/stanley/")
  
@bottle.post('/igraj_proti_racunalniku/stockfish/<barva:path>')
def server_static(barva):
    stanje_trenutnega_uporabnika()
    pot = '/igraj_proti_racunalniku/'
    bottle.response.set_cookie("barva", barva[:-1], path=pot, max_age=1, secret=SKRIVNOST)
    bottle.response.set_cookie("stockfish", True, path=pot, max_age=1, secret=SKRIVNOST)
    bottle.redirect("/igraj_proti_racunalniku/stanley/?stockfish=True")


@bottle.route("/shrani_igro/")
def shrani_igro():
    stanje_trenutnega_uporabnika()
    global vse_skupaj
    uporabnisko_ime = bottle.request.get_cookie("uporabnisko_ime", secret=SKRIVNOST)
    igra = bottle.request.query.igra.replace("_","#")
    celoten_fen = bottle.request.query.fen.replace("_","/")
    beli = bottle.request.get_cookie("beli", secret=SKRIVNOST)
    crni = bottle.request.get_cookie("crni", secret=SKRIVNOST)
    if uporabnisko_ime == beli:
        nasprotnik = crni
    else:
        nasprotnik = beli
    
    # Tole je sicer nekoliko dolgo, vendar berljivo
    if "1-0" in igra:
        rezultat_igre = "W"
        lokalni_rezultat = "Zmaga" if uporabnisko_ime == beli else "Poraz"
        lokalni_rezultat_nasprotnik = "Zmaga" if uporabnisko_ime == crni else "Poraz"
    elif "0-1" in igra:
        rezultat_igre = "B"
        lokalni_rezultat = "Zmaga" if uporabnisko_ime == crni else "Poraz"
        lokalni_rezultat_nasprotnik = "Zmaga" if uporabnisko_ime == beli else "Poraz"
    else:
        rezultat_igre = "D"
        lokalni_rezultat = "Remi"
        lokalni_rezultat_nasprotnik = "Remi"
    seznam_ki_mu_hocemo_dodati_igro = vse_skupaj.v_slovar()["uporabniki"]
    nov_seznam = []
    for account in seznam_ki_mu_hocemo_dodati_igro:
        if account["uporabnisko_ime"] == uporabnisko_ime:
            account["igre"] = account["igre"] + [{"id":len(account["igre"]) + 1, "beli":beli, "crni":crni, "rezultat": rezultat_igre, "lokalni_rezultat": lokalni_rezultat, "igra":igra, "celoten_fen": celoten_fen, "datum":str(datetime.today())}]
        if account["uporabnisko_ime"] == nasprotnik:
            account["igre"] = account["igre"] + [{"id":len(account["igre"]) + 1, "beli":beli, "crni":crni, "rezultat": rezultat_igre, "lokalni_rezultat": lokalni_rezultat_nasprotnik, "igra":igra, "celoten_fen": celoten_fen, "datum":str(datetime.today())}]
        nov_seznam.append(account)
    model.VseSkupaj.v_datoteko({"uporabniki":nov_seznam}, STANJE)
    vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
    bottle.redirect("/")

@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None)

@bottle.post("/prijava/")
def prijava_post():
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo") 
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu, [])
    if uporabnik:
        if uporabnik.zasifrirano_geslo == model.Uporabnik.zasifriraj_geslo(geslo_v_cistopisu):
            bottle.response.set_cookie("uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
            bottle.redirect("/")
        else:
            return bottle.template("prijava.tpl", napaka="Napačno geslo")
    else:
        return bottle.template("prijava.tpl", napaka="Napačno ime")
    
@bottle.get("/registracija/")
def registracija_get():
    return bottle.template("registracija.tpl", napaka=None)

@bottle.post("/registracija/")
def prijava_post():
    global vse_skupaj
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo")
    # Pred registracijo preprečimo nekaj problematičnih primerov
    if uporabnisko_ime in ["Stanley", "Stockfish"]:
                return bottle.template("registracija.tpl", napaka="To ime je rezervirano za računalnike!")
    if not uporabnisko_ime.isascii():
        return bottle.template("registracija.tpl", napaka="Ime uporabnika mora biti ASCII sprejemljivo!")
    if len(uporabnisko_ime) > 20:
        return bottle.template("registracija.tpl", napaka="Ime uporabnika sme vsebovati največ 20 znakov!")
    if len(uporabnisko_ime) == 0:
        return bottle.template("registracija.tpl", napaka="Ime uporabnika ne sme biti prazno!")
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu)
    if uporabnik:   
        return bottle.template("registracija.tpl", napaka="Uporabnik že obstaja!")
    else:
        slovar_z_novim_uporabnikom = dict()
        nov_uporabnik = {'uporabnisko_ime': uporabnisko_ime, 'zasifrirano_geslo': model.Uporabnik.zasifriraj_geslo(geslo_v_cistopisu), 'igre':[]}
        slovar_z_novim_uporabnikom["uporabniki"] = vse_skupaj.v_slovar()["uporabniki"] + [nov_uporabnik]
        model.VseSkupaj.v_datoteko(slovar_z_novim_uporabnikom, STANJE)
        vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
        bottle.response.set_cookie("uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
        bottle.redirect("/")
         
@bottle.get("/igraj_proti_cloveku/")
def igra_proti_cloveku_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("igraj.tpl", vrsta_igre="clovek", nasprotnik = None, napaka = None)

@bottle.post("/igraj_proti_cloveku/")
def igraj_proti_racunalniku_post():
    stanje_trenutnega_uporabnika()
    beli = bottle.request.forms.getunicode("beli")
    crni = bottle.request.forms.getunicode("crni")
    if not beli.isascii() or not crni.isascii():
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                           nasprotnik= None, beli=beli, crni=crni, napaka="Nasprotnik mora imeti ASCII sprejemljivo ime!")
    if beli == "" or crni == "":
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                           nasprotnik= None, beli=beli, crni=crni, napaka="Nasprotnik mora imeti ime!")
    if beli == crni:
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                           nasprotnik= None, beli=beli, crni=crni, napaka="Imeni igralcev morata biti različni!")
    else:
        bottle.response.set_cookie("beli", beli, path="/shrani_igro/", secret=SKRIVNOST)
        bottle.response.set_cookie("crni", crni, path="/shrani_igro/", secret=SKRIVNOST)
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                           nasprotnik= "izbran", beli=beli, crni=crni, napaka=None)

@bottle.get("/igraj_proti_racunalniku/")
def igraj_proti_racunalniku_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("igraj.tpl", vrsta_igre="racunalnik")

@bottle.get("/igraj_proti_racunalniku/stanley/")
def igraj_proti_racunalniku__stanley_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("igraj_stanley.tpl")

@bottle.get("/igraj_proti_racunalniku/stockfish/")
def igraj_proti_racunalniku__stockfish_get():
    stanje_trenutnega_uporabnika()
    return bottle.template("igraj_stockfish.tpl")


# Tole pobriše piškotek uporabnisko_ime ob odjavi
@bottle.post("/odjava/")
def odjava_post():
    bottle.response.delete_cookie("uporabnisko_ime", path = "/", secret=SKRIVNOST)
    bottle.redirect("/")

if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)

