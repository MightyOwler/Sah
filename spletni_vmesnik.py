import bottle
#from bottle import run, route, template

# @bottle.get('/')
# def osnovni_zaslon():
#     return '<h1> Opravila: program za vzbujanje slabe vesti </h1>'

#bottle.TEMPLATE_PATH.insert(0,'/views')

@bottle.get('/')
def index():
    return bottle.template("views/poskus.tpl")

bottle.run(debug=True, host="localhost", reloader=True)