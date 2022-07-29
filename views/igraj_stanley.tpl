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
<title>{{uporabnisko_ime}} proti Stanleyu</title>
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
%if bottle.request.get_cookie('barva', secret=SKRIVNOST) == "beli":
<script type="module" src="../../static/sah_proti_stanleyu_beli.js"></script>
%else:
<script type="module" src="../../static/sah_proti_stanleyu_crni.js"></script>
%end
</head>
<body>
<h1>{{uporabnisko_ime}} proti Stanleyu</h1>
<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Status:</label>
<div id="status"></div>
<label>FEN:</label>
<div id="fen"></div>
<label>Igra:</label> 
<div id="pgn"></div>
</body>
</html>

%end