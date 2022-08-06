<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
%if vrsta_igre == "clovek":
%import bottle
%SKRIVNOST = "blablabla"
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%if nasprotnik == None:
<div class="box">
    <div class="section">
        <div class="columns is-mobile is-centered" style="margin:10px;">
            <h1 class="title is-1 ">Kdo igra proti komu?</h1>
        </div>
        <script src="../static/zamenjaj_barvi.js"></script>
        <div class="columns is-mobile is-centered" style="margin:10px;"><button onclick="zamenjaj_barvi()" class="button is-primary is-medium" style="margin:10px;">Zamenjaj barvi</button></div>
        <form method="POST">
            <div class="field">
        
                <div class="columns is-mobile is-centered" style="margin:10px;">
                <label class="subtitle is-4" style="margin:10px;">Beli:</label>
                    <input id="beli" class="input" name="beli" style="width: 20%; margin:10px;" type="text" value={{uporabnisko_ime}} placeholder="Vpiši ime nasprotnika" readOnly=true>
                    <span class="icon is-small is-left">
                        <i class="fas fa-user"></i>
                    </span>
            </div>
            <div class="field">
                <div class="columns is-mobile is-centered" style="margin:10px;">
                <label class="subtitle is-4" style="margin:10px;">Črni:</label>
                    <input id="crni" class="input" name="crni" style="width: 20%; margin:10px; " type="text" placeholder="Vpiši ime nasprotnika">
                    <span class="icon is-small is-left">
                        <i class="fas fa-lock"></i>
                    </span>
                </div>
            </div>
            <div class="columns is-mobile is-centered" style="margin:10px;">
                <button class="button is-link is-medium" style="margin:10px;">Začni igro</button>
            </div>
        
        </form>
    </div>
</div>
</div>
% if napaka:
        <div class="columns is-mobile is-centered">
            <p class="title help is-danger is-4" style="margin:10px;">{{ napaka }}</p>
        </div>
% end
%else:

<head>
<title>Šah proti lokalnemu nasprotniku</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
<script type="module" src="../static/sah_samo_z_legalnimi_potezami – kopija.js"></script>
<script type="module" src="../static/sah_proti_igralcu.js"></script>
</head>
<body>
<div class="columns is-mobile is-centered">
    <h1 class="subtitle is-1" style="margin:10px;"><strong>{{beli}}</strong> vs. <strong>{{crni}}</strong></h1>
</div>
<div class="columns is-mobile is-centered">
    <chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
</div>
<div class="columns is-mobile is-centered">
    <label class="title is-2" style="margin:10px;">Igra:</label>
</div>
<div class="columns is-mobile is-centered" style="margin:15px;">
    <div id="pgn" class="subtitle is-4" style="margin:10px;"></div>
</div>
<div class="columns is-mobile is-centered">
    <button id="flipOrientationBtn" class="button is-link is-medium" style="margin:10px;">Obrni šahovnico</button>
</div>
        </body>
%end
%else:
<title>Šah proti računalniku</title>
<body>
<div class="box">
    <div class="buttons is-mobile is-centered">
        <form method="GET" action="/igraj_proti_racunalniku/stanley/">
                        <button class="button is-primary is-medium">
                          Igraj proti Stanleyu
                        </button>
                      </form>
                      <form method="GET" action="/igraj_proti_racunalniku/stockfish/">
                        <button class="button is-primary is-medium">
                          Igraj proti Stockfishu
                        </button>
                      </form>
    </div>
</div>

</body>
%end
</html>