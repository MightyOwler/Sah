<!DOCTYPE html>
<html>
<head>
<title>Igranje šaha</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
</head>
<body>


<!-- TA DEL JE POMEMBEN! KAKO SE POŠILJA PODATKE IN PODOBNO! -->
<!-- tu spodaj je treba spremeniti pogoj if defined('uporabnik'), saj ne deluje! Tudi, če smo prijavljeni, še vedno daje za prijavo -->

<div class="buttons">

              %import bottle
              %SKRIVNOST = "blablabla"
              %if bottle.request.get_cookie('uporabnisko_ime'):
              <form method="POST" action="/odjava/">
                <button class="button is-primary is-medium">
                  Odjavi se
                </button>
              </form>
              <form method="GET" action="/igraj_proti_cloveku/">
                <button class="button is-primary is-medium">
                  Igraj proti človeku
                </button>
              </form>
              <form method="GET" action="/igraj_proti_racunalniku/">
                <button class="button is-primary is-medium">
                  Igraj proti računalniku
                </button>
              </form>
              <form method="GET" action="/arhiv/">
                <button class="button is-primary is-medium">
                  Arhiv iger
                </button>
              </form>
              <form method="GET" action="/statistika/">
                <button class="button is-primary is-medium">
                  Statistika
                </button>
              </form>
              <div class = "container">
              <h1>Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>!</h1>
              </div>
              % else:
              <a class="button is-primary is-medium" href="/registracija/">
                <strong>Registriraj se</strong>
              </a>
              <a class="button is-light is-medium" href="/prijava/">
                Prijavi se
              </a>
              % end
            </div>
</body>

</html>