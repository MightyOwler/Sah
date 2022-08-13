<!DOCTYPE html>
<html>
<head>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>
<link rel="icon" href="/static/chess_icon.ico">

</head>
<body>
<div class="box">
  <div class="buttons is-mobile is-centered">
                %import bottle
                %import model
                %SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()

                %if bottle.request.get_cookie('uporabnisko_ime'):
                  <title>Igranje šaha</title>
                  <form method="POST" action="/odjava/">
                    <button class="button is-primary is-large">
                      Odjavi se
                    </button>
                  </form>
                  <form method="GET" action="/igraj_proti_cloveku/">
                    <button class="button is-primary is-large">
                      Igraj proti človeku
                    </button>
                  </form>
                  <form method="GET" action="/igraj_proti_racunalniku/">
                    <button class="button is-primary is-large">
                      Igraj proti računalniku
                    </button>
                  </form>
                  <form method="GET" action="/arhiv/">
                    <button class="button is-primary is-large">
                      Arhiv iger
                    </button>
                  </form>
                  <form method="GET" action="/statistika/">
                    <button class="button is-primary is-large">
                      Statistika
                    </button>
                  </form>

                % else:
                  <title>Prijava in registracija</title>
                  <a class="button is-primary is-large" href="/registracija/">
                    <strong>Registriraj se</strong>
                  </a>
                  <a class="button is-light is-large" href="/prijava/">
                    Prijavi se
                  </a>
                % end
  </div>
</div>
%if bottle.request.get_cookie('uporabnisko_ime'):
<div class="columns is-mobile is-centered" style="margin:10px;">
  %if bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST) == "jasa":
    <h1 class="subtitle is-4 is-spaced">👑 Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>! 👑</h1>
  %elif bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST) == "ziva":
  <h1 class="subtitle is-4 is-spaced">❤️ Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>! ❤️</h1>
 %elif bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST) == "matej":
  <h1 class="subtitle is-4 is-spaced">🐒 Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>! 🐒</h1>
  %else:
  <h1 class="subtitle is-4 is-spaced">Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>!</h1>
  %end
</div>
%else:
<div class="columns is-mobile is-centered" style="margin:10px;">
  <h1 class="subtitle is-4 is-spaced">Prijavi se. Če še nimaš svojega računa, ga ustvari z registracijo.</h1>
</div>
%end
<a class="navbar-item" style="position: fixed; bottom: 10px;"
          href="https://github.com/MightyOwler/Sah">
          <span class="icon">
            <i class="fab fa-github"></i>
          </span>
          <span>GitHub, Jaša Knap 2022</span>
        </a>
</body>


</html>