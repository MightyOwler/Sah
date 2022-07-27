from importlib.resources import path
import bottle
from bottle import template, static_file, route, response
import model

SKRIVNOST = "blablalba" #to je kasneje treba dati v neko datoteko
vse_skupaj = model.VseSkupaj.iz_datoteke("stanje.json")

@bottle.get('/')
def index():
    return bottle.template("views/osnova.tpl")

@route('/static/<ime_dat:path>')
def server_static(ime_dat):
  pot = 'static'
  return bottle.static_file(ime_dat, root=pot)


# ideja je narediti uporabnike, najprej bom samo prekopiral stvar iz projekta **kuverte**

    
@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None)

@bottle.post("/prijava/")
def prijava_post():
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    # tole bom moral spremeniti nazaj, ker zdaj je malo smešno (v resnici je to, kar sem imenoval zasifrirano geslo v json datoteki cistopis) (spodnja vrstica)
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo") 
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu)
    if uporabnik:
        if uporabnik.zasifrirano_geslo == geslo_v_cistopisu:
            bottle.response.set_cookie("uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
            bottle.redirect("/")
        else:
            return bottle.template("prijava.tpl", napaka="Napačno geslo")
    else:
        return bottle.template("prijava.tpl", napaka="Napačno ime")

# tole pobriše piškotek uporabnisko_ime
@bottle.post("/odjava/")
def odjava_post():
    #uporabnisko_ime = bottle.request.get_cookie("uporabnisko_ime")
    response.delete_cookie("uporabnisko_ime", path = "/", secret=SKRIVNOST)
    bottle.redirect("/")


# ni še jasno, ali bom to zares potreboval

# def stanje_trenutnega_uporabnika():
#     uporabnisko_ime = bottle.response.get_cookie('uporabnisko_ime')
#     if uporabnisko_ime:
#         return vse_skupaj.iz_slovarja(f"{uporabnisko_ime}.json")
#     else:
#         bottle.redirect('/prijava/')
        
# to mora biti čisto na dnu

if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)

