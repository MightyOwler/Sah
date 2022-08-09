<!DOCTYPE html>
<html>
<head>
<title>Igranje šaha</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
</head>
<body>
<div class="box">
  <div class="buttons is-mobile is-centered">
                %import bottle
                %SKRIVNOST = "blablabla"

                %if bottle.request.get_cookie('uporabnisko_ime'):
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
  <h1 class="subtitle is-4 is-spaced">Živijo <strong>{{bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)}}</strong>!</h1>
</div>

%else:
<div class="columns is-mobile is-centered" style="margin:10px;">
  <h1 class="subtitle is-4 is-spaced">Prijavi se. Če še nimaš svojega računa, ga ustvari z registracijo.</h1>
</div>
%end
</body>

</html>