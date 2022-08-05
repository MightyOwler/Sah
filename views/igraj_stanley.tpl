<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
%import bottle
%SKRIVNOST = "blablabla"
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%if bottle.request.get_cookie('barva', secret=SKRIVNOST) is None:
<h1 class="title is-1" style="margin:10px;">Izberi barvo</h1>
<form method="POST" action="/igraj_proti_racunalniku/stanley/beli/">
                <button class="button is-primary is-medium" style="margin:10px;">
                  Beli
                </button>
              </form>
<form method="POST" action="/igraj_proti_racunalniku/stanley/crni/">
                <button class="button is-primary is-medium" style="margin:10px;">
                  Črni
                </button>
              </form>
              
%else:

<!DOCTYPE html>
<html>
<head>

<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
%if bottle.request.get_cookie('barva', secret=SKRIVNOST) == "beli":
%bottle.response.set_cookie("beli", uporabnisko_ime, path="/shrani_igro/", secret=SKRIVNOST)
%bottle.response.set_cookie("crni", "Stanley", path="/shrani_igro/", secret=SKRIVNOST)
        
<title>{{uporabnisko_ime}} vs. Stanleyu</title>
<div class="columns is-mobile is-centered">
  <h1 class="subtitle is-1" style="margin:10px;"><strong>{{uporabnisko_ime}}</strong> vs. <strong>Stanley</strong></h1>
</div>
<script type="module" src="../../static/sah_proti_stanley_beli.js"></script>
%else:
%bottle.response.set_cookie("beli", "Stanley", path="/shrani_igro/", secret=SKRIVNOST)
%bottle.response.set_cookie("crni", uporabnisko_ime, path="/shrani_igro/", secret=SKRIVNOST)
<title>Stanley vs. {{uporabnisko_ime}}</title>
<div class="columns is-mobile is-centered">
  <h1 class="subtitle is-1" style="margin:10px;"><strong>Stanley</strong> vs. <strong>{{uporabnisko_ime}}</strong></h1>
</div>
<script type="module" src="../../static/sah_proti_stanley_crni.js"></script>
%end
</head>
<body>

<div class="columns is-mobile is-centered">
  <chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
</div>
<div class="columns is-mobile is-centered"><label class="title is-2" style="margin:10px;">Igra:</label></div> 
<div class="columns is-mobile is-centered">
  <div id="pgn" class="subtitle is-4" style="margin:10px;"></div>
</div>
</body>
</html>

%end