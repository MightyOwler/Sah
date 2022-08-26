%import bottle



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
        labels: ['Zmaga: {{slovar_rezultatov_s_podatki["zmage"]}}', 'Poraz: {{slovar_rezultatov_s_podatki["porazi"]}}', 'Remi: {{slovar_rezultatov_s_podatki["remiji"]}}'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{slovar_rezultatov["zmage"]}}'), parseInt('{{slovar_rezultatov["porazi"]}}'), parseInt('{{slovar_rezultatov["remiji"]}}')],
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
                text: 'Rezultati iger skupno ({{slovar_rezultatov["zmage"] + slovar_rezultatov["porazi"] + slovar_rezultatov["remiji"]}})'
            }
        }
    }
});

const ctx_beli = document.getElementById('myChart_beli').getContext('2d');
const myChart_beli = new Chart(ctx_beli, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga beli: {{slovar_rezultatov_s_podatki["zmage_beli"]}}', 'Poraz beli: {{slovar_rezultatov_s_podatki["porazi_beli"]}}', 'Remi beli: {{slovar_rezultatov_s_podatki["remiji_beli"]}}'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{slovar_rezultatov["zmage_beli"]}}'), parseInt('{{slovar_rezultatov["porazi_beli"]}}'), parseInt('{{slovar_rezultatov["remiji_beli"]}}')],
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
                text: 'Rezultati iger beli ({{slovar_rezultatov["zmage_beli"] + slovar_rezultatov["porazi_beli"] + slovar_rezultatov["remiji_beli"]}})'
            }
        }
    }
});



const ctx_crni = document.getElementById('myChart_crni').getContext('2d');
const myChart_crni = new Chart(ctx_crni, {
    type: 'doughnut',
    data: {
        labels: ['Zmaga črni: {{slovar_rezultatov_s_podatki["zmage_crni"]}}', 'Poraz črni: {{slovar_rezultatov_s_podatki["porazi_crni"]}}', 'Remi črni: {{slovar_rezultatov_s_podatki["remiji_crni"]}}'],
        datasets: [{
            label: '# of Votes',
            data: [parseInt('{{slovar_rezultatov["zmage_crni"]}}'), parseInt('{{slovar_rezultatov["porazi_crni"]}}'), parseInt('{{slovar_rezultatov["remiji_crni"]}}')],
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
                text: 'Rezultati iger črni ({{slovar_rezultatov["zmage_crni"] + slovar_rezultatov["porazi_crni"] + slovar_rezultatov["remiji_crni"]}})'
            }
        }
    }
});
</script>