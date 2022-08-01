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
%zmage, porazi, remiji = 0,0,0
%zmage_beli, porazi_beli, remiji_beli = 0,0,0
%zmage_crni, porazi_crni, remiji_crni = 0,0,0
%for posamezna_igra in vse_uporabnikove_igre:
%   uporabnik_je_bel = posamezna_igra["beli"] == uporabnisko_ime
%   if posamezna_igra["lokalni_rezultat"] == "Zmaga":
%       zmage += 1
%       if uporabnik_je_bel:
%           zmage_beli += 1
%       else:
%           zmage_crni += 1
%       end
%       end
%   if posamezna_igra["lokalni_rezultat"] == "Poraz":
%       porazi += 1
%   if uporabnik_je_bel:
%           porazi_beli += 1
%       else:
%           porazi_crni += 1
%       end
%       end
%   if posamezna_igra["lokalni_rezultat"] == "Remi":
%       remiji += 1
%   if uporabnik_je_bel:
%           remiji_beli += 1
%       else:
%           remiji_crni += 1
%       end
%       end

%end
<head>
<title>Statistika uporabnika {{uporabnisko_ime}}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<div label="skupno" class="level-left" style="width: 600px; float: left;">
<canvas id="myChat_skupno" width="400" height="400"></canvas>
</div>

<div label="beli" class="level-left" style="width: 600px; float: left;">
<canvas id="myChart_beli" width="400" height="400"></canvas>
</div>

<div label="crni" class="level-left" style="width: 600px; float: left;">
<canvas id="myChart_crni" width="400" height="400"></canvas>
</div>

<script>
const ctx_skupno = document.getElementById('myChat_skupno').getContext('2d');
const myChart_skupno = new Chart(ctx_skupno, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga', 'Poraz', 'Remi'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{zmage}}'), parseInt('{{porazi}}'), parseInt('{{remiji}}')],
            backgroundColor: [
                
                'rgba(60, 179, 113, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(90, 90, 90, 0.2)'
            ],
            borderColor: [
                
                'rgba(60, 179, 113, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(90, 90, 90, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        plugins: {
            title: {
                display: true,
                text: 'Skupno'
            }
        }
    }
});

const ctx_beli = document.getElementById('myChart_beli').getContext('2d');
const myChart_beli = new Chart(ctx_beli, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga beli', 'Poraz beli', 'Remi beli'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{zmage_beli}}'), parseInt('{{porazi_beli}}'), parseInt('{{remiji_beli}}')],
            backgroundColor: [
                
                'rgba(60, 179, 113, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(90, 90, 90, 0.2)'
            ],
            borderColor: [
                
                'rgba(60, 179, 113, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(90, 90, 90, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        plugins: {
            title: {
                display: true,
                text: 'Beli'
            }
        }
    }
});



const ctx_crni = document.getElementById('myChart_crni').getContext('2d');
const myChart_crni = new Chart(ctx_crni, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga črni', 'Poraz črni', 'Remi črni'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{zmage_crni}}'), parseInt('{{porazi_crni}}'), parseInt('{{remiji_crni}}')],
            backgroundColor: [
                
                'rgba(60, 179, 113, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(90, 90, 90, 0.2)'
            ],
            borderColor: [
                
                'rgba(60, 179, 113, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(90, 90, 90, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        plugins: {
            title: {
                display: true,
                text: 'Črni'
            }
        }
    }
});

const config = {
  type: 'doughnut',
  data: data,
};
</script>