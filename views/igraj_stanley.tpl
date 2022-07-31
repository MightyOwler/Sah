%import bottle
%SKRIVNOST = "blablabla"
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%if bottle.request.get_cookie('barva', secret=SKRIVNOST) is None:
<h1>Izberi barvo</h1>
<form method="POST" action="/igraj_proti_racunalniku/stanley/beli/">
                <button class="button is-primary">
                  Beli
                </button>
              </form>
<form method="POST" action="/igraj_proti_racunalniku/stanley/crni/">
                <button class="button is-primary">
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
<title>{{uporabnisko_ime}} vs. Stanleyu</title>
<h1>{{uporabnisko_ime}} vs. Stanleyu</h1>
<script type="module" src="../../static/sah_proti_stanleyu_beli.js"></script>
%else:
<title>Stanley vs. {{uporabnisko_ime}}</title>
<h1>Stanley vs. {{uporabnisko_ime}}</h1>
<script type="module" src="../../static/sah_proti_stanleyu_crni.js"></script>
%end
</head>
<body>

<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Igra:</label> 
<div id="pgn"></div>
</body>
</html>

%end