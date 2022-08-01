<!DOCTYPE html>
<html>

%import bottle
%import model
%SKRIVNOST = "blablabla"
%STANJE = "stanje.json"



%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
%uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
%vse_uporabnikove_igre = uporabnik.igre
%for posamezna_igra in vse_uporabnikove_igre:

%if str(posamezna_igra["id"]) == id:
%   igra = posamezna_igra["igra"]
%   beli = posamezna_igra["beli"]
%   crni = posamezna_igra["crni"]
%   id_igre = str(posamezna_igra["id"])
%   celoten_fen = posamezna_igra["celoten_fen"].split(",")
%   break
%end
%end
%popravljen_celoten_fen = [i.split(" ")[0] for i in celoten_fen]


<head>
<title>Analiza igre {{[beli]}} vs. {{[crni]}}</title>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css"> -->
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
</head>
<body>
<h1>Analiza igre: {{beli}} vs. {{crni}}</h1>
<chess-board id="sahovnica" style="width: 600px" position="start"></chess-board>
<label>Igra:</label>
<div id="pgn">{{igra}}</div>
<button id="nazaj">Nazaj</button>
<button id="naprej">Naprej</button>
<button id="flipOrientationBtn">Obrni šahovnico</button>
</body>
<script> const board = document.querySelector('chess-board');
const searchRegExp = /&#039/g; 
const replaceWith = '';
var celotna_igra = '{{str(popravljen_celoten_fen)}}'.replace(searchRegExp, replaceWith).replace(/;/g, replaceWith);
</script>
<script src="/../static/arhiv_iger.js"></script>   
</html>

