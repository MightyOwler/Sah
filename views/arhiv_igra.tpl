<!DOCTYPE html>
<html>
<head>
<title>Analiza igre: {{beli}} vs. {{crni}}</title>
<link rel="icon" href="/static/chess_icon.ico">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
</head>
<body>
<div class="columns is-mobile is-centered">
<h1 class="subtitle is-1 " style="margin:10px;">Analiza igre: <strong>{{beli}}</strong> vs. <strong>{{crni}}</strong></strong></h1>
</div>
<div class="columns is-mobile is-centered">
    <chess-board id="sahovnica" style="width: 600px" position="start"></chess-board>
</div>
<div class="columns is-mobile is-centered"><label class="title is-2" style="margin:10px;">Igra:</label></div>
<div class="columns is-mobile is-centered" style="margin:15px;">
    <div id="pgn" class="subtitle is-4" style="margin:10px;">{{igra}}</div>
</div>
<div class="columns is-mobile is-centered">
    <button id="nazaj" class="button is-link is-medium" style="margin:10px;">Nazaj</button>
    <button id="naprej" class="button is-link is-medium" style="margin:10px;">Naprej</button>
    <button id="flipOrientationBtn" class="button is-link is-medium" style="margin:10px;">Obrni šahovnico</button>
</div>
</body>
<script> const board = document.querySelector('chess-board');
const searchRegExp = /&#039/g; 
const replaceWith = '';
var celotna_igra = '{{str(popravljen_celoten_fen)}}'.replace(searchRegExp, replaceWith).replace(/;/g, replaceWith);
var uporabnisko_ime = '{{uporabnisko_ime}}';
var crni = '{{crni}}';
</script>
<script type = "module" src="/../static/arhiv_iger.js"></script>   
</html>

