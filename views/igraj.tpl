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
        <div class="columns is-mobile is-centered" style="margin:10px;"><button onclick="zamenjaj_barvi()" class="button is-primary is-large" style="margin:10px;">Zamenjaj barvi</button></div>
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
                <button class="button is-link is-large" style="margin:10px;">Začni igro</button>
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
<script type="module" src="../static/sah_samo_z_legalnimi_potezami.js"></script>
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
        <button id="undo" class="button is-link is-medium" style="margin:10px;">Popravi potezo</button>
</div>

        </body>
%end
%else:
<title>Šah proti računalniku</title>
<body>
<style>

img {
    width:200%;
    height:200%;

}


</style>
<div class="box">
    <div class="columns is-mobile is-centered" style="margin:10px;">
        <div class = "column">
            <div class="buttons is-mobile is-centered">
                <div>
                    <form method="GET" action="/igraj_proti_racunalniku/stanley/">
                        <button class="button is-primary is-large" style="margin:10px 50px;">
                            Igraj proti Stanleyu
                        </button>
                    </form>
                </div>
                <div>
                    <form method="GET" action="/igraj_proti_racunalniku/stockfish/">
                        <button class="button is-primary is-large" style="margin:10px 50px;">
                            Igraj proti Stockfishu
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

<div class="columns" is-mobile is-centered>
            <div class = "column" style="display: flex; justify-content:right;"> 
                <figure class="image is-128x128" style="width:30%; height:30%; margin:0px 40px;">
                    <img class="is-rounded" src="../static/stanley-icon.png" >
                </figure>
            </div>
    
    
            <div class = "column" style="display: flex; justify-content:left;">
                <figure class="image is-128x128" style="width:32%; height:32%; margin:0px 30px;">
                    <img class="is-rounded" src="../static/stockfish-icon.png">
                </figure>
            </div>
    
</div>

<div class="columns" is-mobile is-centered>
            <div class = "column" > 
                <div class="block" style="display: flex; justify-content:right; margin:0px 50px;">
                    <h1 style="width: 250px;"><em><strong>Stanley</strong> sicer zna premikati figure, ampak ne igra prav dobro. Kljub temu ga ne podcenjuj!</em> <br><br> Slog: <em>naključen</em> <br><br>Rating: 1</h1>
                    
                </div>
            </div>
    
                
            <div class = "column" style="display: flex; justify-content:left; width: 250px";">
                <div class="block" style="display: flex; justify-content:left; margin:0px 50px;">
                    <h1 style="width: 250px;"><em><strong>Stockfish</strong> uživa neizmerno slavo kot eden izmed najboljših šahovskih programov. (trenutno na dopustu!)</em> <br><br> Slog: <em>brutalen</em> <br><br>Rating: 3390</h1>

                </div>
            </div>
    
</div>

</div>


   
</body>
%end
</html>