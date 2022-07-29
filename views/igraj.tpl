
<!DOCTYPE html>
<html>
%if vrsta_igre == "clovek":
<head>
<title>Šah proti nasprotniku</title>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css"> -->
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
<script type="module" src="../static/sah_samo_z_legalnimi_potezami.js"></script>
<script type="module" src="../static/sah_proti_igralcu.js"></script>
</head>
<body>
<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Status:</label>
<div id="status"></div>
<label>FEN:</label>
<div id="fen"></div>
<label>Igra:</label>
<div id="pgn"></div>
<button id="flipOrientationBtn">Obrni šahovnico</button>
</body>
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

