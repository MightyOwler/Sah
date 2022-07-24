import bottle
from bottle import template, static_file, route
# @bottle.get('/')
# def osnovni_zaslon():
#     return '<h1> Opravila: program za vzbujanje slabe vesti </h1>'

@bottle.get('/')
def index():
    return bottle.template("views/osnova.tpl")

if __name__ == '__main__':
    bottle.run(debug=True, host="localhost", reloader=True)

# tole je še rahlo sumljivo, ampak sem vedno bližje pravi rešitvi
# @route('/static/:filename:')
# def send_static(filename):
#     return static_file(filename, root='./static/')

# @route('/static/<ime_dat:path>')
# def server_static(ime_dat):
#   pot = 'static'
#   return bottle.static_file(ime_dat, root=pot)

@route('/static/:filename:')
def send_static(filename):
    return static_file(filename, root='./static/')