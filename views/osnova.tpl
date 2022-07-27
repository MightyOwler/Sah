<!DOCTYPE html>
<html>
<head>
<title>Šah proti nasprotniku</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">

<!-- 
<link rel="stylesheet" href="/static/stil.css"> 

tukaj bom dal svoj css, da bo lep izgled
-->

</head>
<body>
<script type="module" src="https://unpkg.com/chessboard-element?module"></script>
<script src="https://justinfagnani.github.io/chessboard-element/js/chess-0.10.2.min.js"></script>
<script type="module" src="static/sah_samo_z_legalnimi_potezami.js"></script>
<!-- to ne spada v base!! Tukaj se bo najprej registriralo, nato pa igralo igro!!
<chess-board style="width: 600px" position="start" draggable-pieces=""></chess-board>
<label>Status:</label>
<div id="status"></div>
<label>FEN:</label>
<div id="fen"></div>
<label>Igra:</label>
<div id="pgn"></div>
-->

<!-- TA DEL JE POMEMBEN! KAKO SE POŠILJA PODATKE IN PODOBNO! -->
<!-- tu spodaj je treba spremeniti pogoj if defined('uporabnik'), saj ne deluje! Tudi, če smo prijavljeni, še vedno daje za prijavo -->

<div class="buttons">
              %import bottle
              %if bottle.request.get_cookie('uporabnisko_ime'):
              <form method="POST" action="/odjava/">
                <button class="button is-primary">
                  Odjavi se
                </button>
              </form>
              % else:
              <a class="button is-primary" href="/registracija/">
                <strong>Registriraj se</strong>
              </a>
              <a class="button is-light" href="/prijava/">
                Prijavi se
              </a>
              % end
            </div>
</body>
</html>