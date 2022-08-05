<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
%if vrsta_igre == "clovek":
%import bottle
%SKRIVNOST = "blablabla"
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%if nasprotnik == None:

<div class="columns is-mobile is-centered" style="margin:10px;">
    <h1 class="title is-1 ">Kdo igra proti komu?</h1>
</div>
<script src="../static/zamenjaj_barvi.js"></script>
<button onclick="zamenjaj_barvi()" class="button is-primary is-medium" style="margin:10px;">Zamenjaj barvi</button>
<form method="POST">
    <div class="field">
        <label class="title is-4" style="margin:10px;">Beli</label>
        <div class="control has-icons-left">
            <input id="beli" class="input" name="beli" style="width: 20%; margin:10px;" type="text" value={{uporabnisko_ime}} placeholder="Vpiši ime nasprotnika" readOnly=true>
            <span class="icon is-small is-left">
                <i class="fas fa-user"></i>
            </span>
    </div>
    <div class="field" >
        <label class="title is-4" style="margin:10px;">Črni</label>
        <div class="control has-icons-left">
            <input id="crni" class="input" name="crni" style="width: 20%; margin:10px; " type="text" placeholder="Vpiši ime nasprotnika">
            <span class="icon is-small is-left">
                <i class="fas fa-lock"></i>
            </span>
        </div>
    </div>
    <div class="field is-grouped">
        <div class="control">
            <button class="button is-link is-medium" style="margin:10px;">Začni igro</button>
        </div>
    </div>
</form>
% if napaka:
        <p class="title help is-danger is-4" style="margin:10px;">{{ napaka }}</p>
% end


%else:

<head>
<title>Šah proti nasprotniku</title>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css"> -->
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
<script type="module" src="../static/sah_samo_z_legalnimi_potezami.js"></script>
<script type="module" src="../static/sah_proti_igralcu.js"></script>
</head>
<body>
<h1>{{beli}} vs. {{crni}}</h1>
<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Status:</label>
<div id="status"></div>
<label>FEN:</label>
<div id="fen"></div>
<label>Igra:</label>
<div id="pgn"></div>
<button id="flipOrientationBtn">Obrni šahovnico</button>
</body>
%end
%else:
<title>Šah proti računalniku</title>
<body>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<form method="GET" action="/igraj_proti_racunalniku/stanley/">
                <button class="button is-primary">
                  Igraj proti Stanleyu
                </button>
              </form>
              <form method="GET" action="/igraj_proti_racunalniku/stockfish/">
                <button class="button is-primary">
                  Igraj proti Stockfishu
                </button>
              </form>

</body>
%end
</html>