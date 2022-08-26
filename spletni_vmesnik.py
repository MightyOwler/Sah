import bottle
import model
from datetime import datetime

SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()
STANJE = "stanje.json"
vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)


# V primeru, da uporabnik izbirše piškotek, ga to preusmeri začetno stran
# v poisci_uporabnika



@bottle.get('/')
def index():
    return bottle.template("views/osnova.tpl")


@bottle.route('/static/<ime_dat:path>')
def server_static(ime_dat):
    pot = 'static'
    return bottle.static_file(ime_dat, root=pot)


@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None)


@bottle.post("/prijava/")
def prijava_post():
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo")
    uporabnik = vse_skupaj.poisci_uporabnika(
        uporabnisko_ime, prijavljanje= True)
    print(geslo_v_cistopisu, uporabnisko_ime)
    if uporabnik:
        if uporabnik.zasifrirano_geslo == model.Uporabnik.zasifriraj_geslo(geslo_v_cistopisu):
            bottle.response.set_cookie(
                "uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
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
    # To bi se dalo dati v pomožno funkcijo
    if uporabnisko_ime in ["Stanley", "Stockfish", "Stocknoob"]:
        return bottle.template("registracija.tpl", napaka="To ime je rezervirano za računalnike!")
    if not uporabnisko_ime.isascii():
        return bottle.template("registracija.tpl", napaka="Ime uporabnika mora biti ASCII sprejemljivo!")
    if len(uporabnisko_ime) > 20:
        return bottle.template("registracija.tpl", napaka="Ime uporabnika sme vsebovati največ 20 znakov!")
    if len(uporabnisko_ime) == 0:
        return bottle.template("registracija.tpl", napaka="Ime uporabnika ne sme biti prazno!")
    uporabnik = vse_skupaj.poisci_uporabnika(
        uporabnisko_ime)
    if uporabnik:
        return bottle.template("registracija.tpl", napaka="Uporabnik že obstaja!")
    else:
        slovar_z_novim_uporabnikom = dict()
        nov_uporabnik = {'uporabnisko_ime': uporabnisko_ime,
                         'zasifrirano_geslo': model.Uporabnik.zasifriraj_geslo(geslo_v_cistopisu), 'igre': []}
        slovar_z_novim_uporabnikom["uporabniki"] = vse_skupaj.v_slovar()[
            "uporabniki"] + [nov_uporabnik]
        model.VseSkupaj.v_datoteko(slovar_z_novim_uporabnikom, STANJE)
        vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
        bottle.response.set_cookie(
            "uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
        bottle.redirect("/")


@bottle.get("/igraj_proti_racunalniku/")
def igraj_proti_racunalniku_get():
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    return bottle.template("igraj.tpl", vrsta_igre="racunalnik")

# Tole preveri oba primera: Stanley in Stockfish (po novem tudi Stocknoob)


@bottle.get("/igraj_proti_racunalniku/<racunalniski_nasprotnik:path>/")
def server_static(racunalniski_nasprotnik):
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    uporabnisko_ime = model.PrikazovanjeStrani.igraj_proti_racunalniku()
    return bottle.template(f"igraj_{racunalniski_nasprotnik}.tpl", SKRIVNOST = SKRIVNOST, uporabnisko_ime = uporabnisko_ime)



# To preveri oba primera: Stanley in Stockfish
@bottle.post('/igraj_proti_racunalniku/<racunalniski_nasprotnik:path>/<barva:path>')
def server_static(racunalniski_nasprotnik, barva):
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()
    pot = '/igraj_proti_racunalniku/'
    
    bottle.response.set_cookie(
        "barva", barva[:-1], path=pot, max_age=1, secret=SKRIVNOST)
    if racunalniski_nasprotnik == "stanley":
        bottle.redirect("/igraj_proti_racunalniku/stanley/")
        #return bottle.template("igraj_stanley.tpl", SKRIVNOST=SKRIVNOST)
    else:
        bottle.redirect("/igraj_proti_racunalniku/stockfish/")
        #return bottle.template("igraj_stockfish.tpl", SKRIVNOST=SKRIVNOST)


@bottle.get("/igraj_proti_cloveku/")
def igra_proti_cloveku_get():
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    return bottle.template("igraj.tpl", vrsta_igre="clovek", nasprotnik=None, napaka=None)


@bottle.post("/igraj_proti_cloveku/")
def igraj_proti_racunalniku_post():
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    beli = bottle.request.forms.getunicode("beli")
    crni = bottle.request.forms.getunicode("crni")
    if beli in ["Stanley", "Stockfish", "Stocknoob"] or crni in ["Stanley", "Stockfish", "Stocknoob"]:
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik=None, beli=beli, crni=crni, napaka="To ime je rezervirano za računalnike!")
    if len(beli) > 20 or len(crni) > 20:
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik=None, beli=beli, crni=crni, napaka="Ime nasprotnika sme vsebovati največ 20 znakov!")
    if beli == "" or crni == "":
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik=None, beli=beli, crni=crni, napaka="Nasprotnik mora imeti ime!")
    if not beli.isascii() or not crni.isascii():
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik=None, beli=beli, crni=crni, napaka="Nasprotnik mora imeti ASCII sprejemljivo ime!")
    if beli == crni:
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik=None, beli=beli, crni=crni, napaka="Imeni igralcev morata biti različni!")
    else:
        bottle.response.set_cookie(
            "beli", beli, path="/shrani_igro/", secret=SKRIVNOST)
        bottle.response.set_cookie(
            "crni", crni, path="/shrani_igro/", secret=SKRIVNOST)
        return bottle.template("igraj.tpl", vrsta_igre="clovek",
                               nasprotnik="izbran", beli=beli, crni=crni, napaka=None)



@bottle.route("/shrani_igro/")
def shrani_igro():
    global vse_skupaj
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    uporabnisko_ime = bottle.request.get_cookie(
        "uporabnisko_ime", secret=SKRIVNOST)
    igra = bottle.request.query.igra.replace("_", "#")
    celoten_fen = bottle.request.query.fen.replace("_", "/")
    beli = bottle.request.get_cookie("beli", secret=SKRIVNOST)
    crni = bottle.request.get_cookie("crni", secret=SKRIVNOST)
    if uporabnisko_ime == beli:
        nasprotnik = crni
    else:
        nasprotnik = beli

    rezultat_igre, lokalni_rezultat, lokalni_rezultat_nasprotnik = model.VseSkupaj.doloci_lastnosti_odigrane_igre(
        igra, uporabnisko_ime, beli, crni)

    seznam_ki_mu_hocemo_dodati_igro = vse_skupaj.v_slovar()["uporabniki"]
    nov_seznam = []
    for account in seznam_ki_mu_hocemo_dodati_igro:
        if account["uporabnisko_ime"] == uporabnisko_ime:
            account["igre"] = account["igre"] + [{"id": len(account["igre"]) + 1, "beli":beli, "crni":crni, "rezultat": rezultat_igre,
                                                  "lokalni_rezultat": lokalni_rezultat, "igra":igra, "celoten_fen": celoten_fen, "datum":str(datetime.today())}]
        if account["uporabnisko_ime"] == nasprotnik:
            account["igre"] = account["igre"] + [{"id": len(account["igre"]) + 1, "beli":beli, "crni":crni, "rezultat": rezultat_igre,
                                                  "lokalni_rezultat": lokalni_rezultat_nasprotnik, "igra":igra, "celoten_fen": celoten_fen, "datum":str(datetime.today())}]
        nov_seznam.append(account)
    model.VseSkupaj.v_datoteko({"uporabniki": nov_seznam}, STANJE)
    vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
    bottle.redirect("/")


@bottle.get("/statistika/")
def arhiv_get():
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    return bottle.template("statistika.tpl")


@bottle.get("/arhiv/")
def arhiv_get():
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    uporabnisko_ime, vse_uporabnikove_igre = model.PrikazovanjeStrani.arhiv()
    return bottle.template("arhiv.tpl", uporabnisko_ime = uporabnisko_ime, vse_uporabnikove_igre = vse_uporabnikove_igre)


@bottle.get("/arhiv/<id:path>")
def server_static(id):
    model.VseSkupaj.poisci_uporabnika(vse_skupaj)
    uporabnisko_ime, igra, beli, crni, popravljen_celoten_fen = model.PrikazovanjeStrani.arhiv_igra(id)
    return bottle.template("arhiv_igra.tpl", SKRIVNOST=SKRIVNOST, STANJE=STANJE, vse_skupaj=vse_skupaj, uporabnisko_ime = uporabnisko_ime, igra = igra, beli = beli, crni = crni, popravljen_celoten_fen = popravljen_celoten_fen, id=id[:-1])


# Tole pobriše piškotek uporabnisko_ime ob odjavi
@bottle.post("/odjava/")
def odjava_post():
    bottle.response.delete_cookie(
        "uporabnisko_ime", path="/", secret=SKRIVNOST)
    bottle.redirect("/")


if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)
