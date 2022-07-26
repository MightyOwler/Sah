<!DOCTYPE html>
<html>
<head>
<title>Šah proti nasprotniku</title>
</head>
<body>
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
<script type="module" src="static/sah_samo_z_legalnimi_potezami.js"></script>
<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Status:</label>
<div id="status"></div>
<label>FEN:</label>
<div id="fen"></div>
<label>Igra:</label>
<div id="pgn"></div>
</body>
</html>