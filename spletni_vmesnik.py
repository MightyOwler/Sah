import bottle
import model
from datetime import datetime

SKRIVNOST = "blablabla" #to je kasneje treba dati v neko datoteko
STANJE = "stanje.json"
vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
@bottle.get('/')
def index():
    bottle.response.delete_cookie("barva", path = "/igraj_proti_racunalniku/", secret=SKRIVNOST)
    return bottle.template("views/osnova.tpl")

@bottle.route('/static/<ime_dat:path>')
def server_static(ime_dat):
  pot = 'static'
  return bottle.static_file(ime_dat, root=pot)


@bottle.post('/igraj_proti_racunalniku/stanley/<barva:path>')
def server_static(barva):
  pot = '/igraj_proti_racunalniku/'
  bottle.response.set_cookie("barva", barva[:-1], path=pot, secret=SKRIVNOST)
  bottle.redirect("/igraj_proti_racunalniku/stanley/")

@bottle.route("/shrani_igro/")
def shrani_igro():
    global vse_skupaj
    # spremeniti smo morali url, da se podatki niso izgubili 
    igra = bottle.request.query.igra.replace("_","#")
    print("Shranjena je igra:", igra)
    # tukaj je treba v resnici še dodati ime nasprotnika, kar bomo storili s pomočjo button posta
    uporabnisko_ime = bottle.request.get_cookie("uporabnisko_ime", secret=SKRIVNOST)
    list_ki_mu_hocemo_dodati_igro = vse_skupaj.v_slovar()["uporabniki"]
    print(list_ki_mu_hocemo_dodati_igro)
    nov_list = []
    for account in list_ki_mu_hocemo_dodati_igro:
        if account["uporabnisko_ime"] == uporabnisko_ime:
            account["igre"] = account["igre"] + [(uporabnisko_ime, igra, str(datetime.today()))]
        nov_list.append(account)
    model.VseSkupaj.v_datoteko({"uporabniki":nov_list}, STANJE)
    vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
    bottle.redirect("/")

@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None)

@bottle.post("/prijava/")
def prijava_post():
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    # tole bom moral spremeniti nazaj, ker zdaj je malo smešno (v resnici je to, kar sem imenoval zasifrirano geslo v json datoteki cistopis) (spodnja vrstica)
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo") 
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu, [])
    if uporabnik:
        print(uporabnik)
        if uporabnik.zasifrirano_geslo == geslo_v_cistopisu:
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
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu)
    if uporabnik:
        return bottle.template("registracija.tpl", napaka="Uporabnik že obstaja!")
    else:
        nov_uporabnik = model.Uporabnik(uporabnisko_ime, geslo_v_cistopisu, [])
        slovar_z_novim_uporabnikom = dict()
        slovar_z_novim_uporabnikom["uporabniki"] = vse_skupaj.v_slovar()["uporabniki"] + [{'uporabnisko_ime': uporabnisko_ime, 'zasifrirano_geslo': geslo_v_cistopisu, 'igre':[]}]
        # na tem mestu sem spremenil metodo v_datoteko iz model.py 
        # (json.dump(self.v_slovar()) --> json.dump(self))
        model.VseSkupaj.v_datoteko(slovar_z_novim_uporabnikom, STANJE)
        # naslednja vrstica je zato, da pravilno deluje prijava
        vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
        bottle.response.set_cookie("uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
        bottle.redirect("/")
        
# v resnici bosta bila na strani /odjava/ dva ustrezna gumba z ustreznimi POST 
@bottle.get("/igraj_proti_cloveku/")
def igra_proti_cloveku_get():
    return bottle.template("igraj.tpl", vrsta_igre="clovek", nasprotnik = None)

@bottle.post("/igraj_proti_cloveku/")
def igraj_proti_racunalniku_post():
    beli = bottle.request.forms.getunicode("beli")
    crni = bottle.request.forms.getunicode("crni")
    return bottle.template("igraj.tpl", vrsta_igre="clovek", nasprotnik= "izbran", beli=beli, crni=crni)

@bottle.get("/igraj_proti_racunalniku/")
def igraj_proti_racunalniku_get():
    return bottle.template("igraj.tpl", vrsta_igre="racunalnik")


@bottle.get("/igraj_proti_racunalniku/stanley/")
def igraj_proti_racunalniku__stanley_get():
    return bottle.template("igraj_stanley.tpl")

@bottle.get("/igraj_proti_racunalniku/stockfish/")
def igraj_proti_racunalniku__stockfish_get():
    return bottle.template("igraj_stockfish.tpl")

    # treba je še naštimati ustrezno barvo figur
    

# tole pobriše piškotek uporabnisko_ime
@bottle.post("/odjava/")
def odjava_post():
    bottle.response.delete_cookie("uporabnisko_ime", path = "/", secret=SKRIVNOST)
    bottle.redirect("/")

# to mora biti čisto na dnu
if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)

