import bottle
from bottle import static_file, route, template
#from bottle import run, route, template

# @bottle.get('/')
# def osnovni_zaslon():
#     return '<h1> Opravila: program za vzbujanje slabe vesti </h1>'

#bottle.TEMPLATE_PATH.insert(0,'/views')

@bottle.get('/')
def index():
    return bottle.template("views/poskus.tpl")

# @bottle.get('/static/sah_samo_z_legalnimi_potezami.js')
# def index():
#     return bottle.template("views/poskus.tpl")

bottle.run(debug=True, host="localhost", reloader=True)

# tole je še rahlo sumljivo, ampak sem vedno bližje pravi rešitvi
# @route('/static/:filename:')
# def send_static(filename):
#     return static_file(filename, root='./static/')

# @bottle.get('/static/<ime_dat:path>')
def server_static(ime_dat):
  pot = 'static'
  return bottle.static_file(ime_dat, root=pot)
