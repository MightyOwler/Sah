%import bottle
%import model
%SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()
%STANJE = "stanje.json"
%vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
%vse_uporabnikove_igre = uporabnik.igre
%zmage, porazi, remiji = 0,0,0
%zmage_beli, porazi_beli, remiji_beli = 0,0,0
%zmage_crni, porazi_crni, remiji_crni = 0,0,0
%def pridobi_podatek_o_odstotkih(n1, n2, n3, n4):
%    if n2 + n3 + n4 != 0:
%        return '{:.1%}'.format(n1/(n2 + n3 + n4))
%    else:
%       return "ni podatka"
%    end
%end
%for posamezna_igra in vse_uporabnikove_igre:
%   uporabnik_je_bel = posamezna_igra["beli"] == uporabnisko_ime
%   if posamezna_igra["lokalni_rezultat"] == "Zmaga":
%       zmage += 1
%       if uporabnik_je_bel:
%           zmage_beli += 1
%       else:
%           zmage_crni += 1
%       end
%   end
%   if posamezna_igra["lokalni_rezultat"] == "Poraz":
%       porazi += 1
%       if uporabnik_je_bel:
%           porazi_beli += 1
%       else:
%           porazi_crni += 1
%       end
%   end
%   if posamezna_igra["lokalni_rezultat"] == "Remi":
%       remiji += 1
%       if uporabnik_je_bel:
%           remiji_beli += 1
%       else:
%           remiji_crni += 1
%       end
%   end
%end


<title>Statistika uporabnika {{uporabnisko_ime}}</title>
<link rel="icon" href="/static/chess_icon.ico">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="columns is-mobile is-centered">
<h1 class="subtitle is-1 " style="margin:10px;">Statistika uporabnika <strong>{{uporabnisko_ime}}</strong></h1>
</div>
<div class="section">
    <div label="skupno" class="level-left" style="width: 600px; float: left;">
    <canvas id="myChat_skupno" width="400" height="400"></canvas>
    </div>
    
    <div label="beli" class="level-left" style="width: 600px; float: left;">
    <canvas id="myChart_beli" width="400" height="400"></canvas>
    </div>
    
    <div label="crni" class="level-left" style="width: 600px; float: left;">
    <canvas id="myChart_crni" width="400" height="400"></canvas>
    </div>
</div>


<!-- To spodaj v scriptu bi bilo morda elegantno dati v statično 
.js datoteko, ampak bi bilo nekoliko zoprno prenesti podatke, poleg
tega pa dejansko ni tako problematično, tudi če pustimo -->

<script>

const ctx_skupno = document.getElementById('myChat_skupno').getContext('2d');
const myChart_skupno = new Chart(ctx_skupno, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga: {{pridobi_podatek_o_odstotkih(zmage, zmage, porazi, remiji)}}', 'Poraz: {{pridobi_podatek_o_odstotkih(porazi, zmage, porazi, remiji)}}', 'Remi: {{pridobi_podatek_o_odstotkih(remiji, zmage, porazi, remiji)}}'],
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
                text: 'Rezultati iger skupno ({{zmage + porazi + remiji}})'
            }
        }
    }
});

const ctx_beli = document.getElementById('myChart_beli').getContext('2d');
const myChart_beli = new Chart(ctx_beli, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga beli: {{pridobi_podatek_o_odstotkih(zmage_beli, zmage_beli, porazi_beli, remiji_beli)}}', 'Poraz beli: {{pridobi_podatek_o_odstotkih(porazi_beli, zmage_beli, porazi_beli, remiji_beli)}}', 'Remi beli: {{pridobi_podatek_o_odstotkih(remiji_beli, zmage_beli, porazi_beli, remiji_beli)}}'],
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
                text: 'Rezultati iger beli ({{zmage_beli + porazi_beli + remiji_beli}})'
            }
        }
    }
});



const ctx_crni = document.getElementById('myChart_crni').getContext('2d');
const myChart_crni = new Chart(ctx_crni, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga črni: {{pridobi_podatek_o_odstotkih(zmage_crni, zmage_crni, porazi_crni, remiji_crni)}}', 'Poraz črni: {{pridobi_podatek_o_odstotkih(porazi_crni, zmage_crni, porazi_crni, remiji_crni)}}', 'Remi črni: {{pridobi_podatek_o_odstotkih(remiji_crni, zmage_crni, porazi_crni, remiji_crni)}}'],
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
                text: 'Rezultati iger črni ({{zmage_crni + porazi_crni + remiji_crni}})'
            }
        }
    }
});
</script>