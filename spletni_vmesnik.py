import bottle
from bottle import template, static_file, route
# @bottle.get('/')
# def osnovni_zaslon():
#     return '<h1> Opravila: program za vzbujanje slabe vesti </h1>'

@bottle.get('/')
def index():
    return bottle.template("views/osnova.tpl")

@route('/static/<ime_dat:path>')
def server_static(ime_dat):
  pot = 'static'
  return bottle.static_file(ime_dat, root=pot)

# tole je še rahlo sumljivo, vrže error 500
# @route('/static/:filename:')
# def send_static(filename):
#     return static_file(filename, root='./static/')

if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)
    







