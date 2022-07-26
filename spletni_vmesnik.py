import bottle
from bottle import template, static_file, route
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
    return bottle.template("prijava.html", napaka=None)

@bottle.post("/prijava/")
def prijava_post():
    uporabnisko_ime = bottle.request.forms.getunicode("uporabnisko_ime")
    # tole bom moral spremeniti nazaj, ker zdaj je malo smešno (v resnici je to, kar sem imenoval zasifrirano geslo v json datoteki cistopis) (spodnja vrstica)
    geslo_v_cistopisu = bottle.request.forms.getunicode("zasifrirano_geslo") 
    uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime, geslo_v_cistopisu)
    if uporabnik:
        bottle.response.set_cookie("uporabnisko_ime", uporabnisko_ime, path="/", secret=SKRIVNOST)
        bottle.redirect("/")
    else:
        return bottle.template("prijava.html", napaka="Napačno geslo")

@bottle.post("/odjava/")
def odjava_post():
    bottle.response.delete_cookie("uporabnisko_ime")
    bottle.redirect("/")

if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)

