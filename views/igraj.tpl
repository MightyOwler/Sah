
<!DOCTYPE html>
<html>
%if vrsta_igre == "clovek":
%import bottle
%SKRIVNOST = "blablabla"
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%if nasprotnik == None:
<h1>Kdo igra proti komu?</h1>
<script>
//zamenjamo vrednost polj
function zamenjaj_barvi() {
    beli = document.getElementById('beli');   
    crni = document.getElementById('crni');
    vrednost_beli = beli.value;
    vrednost_crni = crni.value;
    beli.value = vrednost_crni;
    crni.value = vrednost_beli;

    if (beli.readOnly){
      beli.readOnly = false;
    } else {beli.readOnly = true;}

    if (crni.readOnly){
      crni.readOnly = false;
    } else {crni.readOnly = true;}
}
</script>
<button onclick="zamenjaj_barvi()">Zamenjaj barvi</button>
<form method="POST">
    <div class="field">
        <label class="label">Beli</label>
        <div class="control has-icons-left">
            <input id="beli" class="input" name="beli" type="text" value={{uporabnisko_ime}} placeholder="Vpiši ime nasprotnika" readOnly=true>
            <span class="icon is-small is-left">
                <i class="fas fa-user"></i>
            </span>
    </div>
    <div class="field">
        <label class="label">Črni</label>
        <div class="control has-icons-left">
            <input id="crni" class="input" name="crni" type="text" placeholder="Vpiši ime nasprotnika">
            <span class="icon is-small is-left">
                <i class="fas fa-lock"></i>
            </span>
        </div>
    </div>
    <div class="field is-grouped">
        <div class="control">
            <button class="button is-link">Začni igro</button>
        </div>
    </div>
</form>
% if napaka:
        <p class="help is-danger">{{ napaka }}</p>
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

