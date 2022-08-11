<!DOCTYPE html>
<html>
%import bottle
%import model
%SKRIVNOST = model.VseSkupaj.preberi_skrivnost_iz_datoteke()
%STANJE = "stanje.json"
%vse_skupaj = model.VseSkupaj.iz_datoteke(STANJE)
%uporabnisko_ime = bottle.request.get_cookie('uporabnisko_ime', secret=SKRIVNOST)
%uporabnik = vse_skupaj.poisci_uporabnika(uporabnisko_ime)
%vse_uporabnikove_igre = uporabnik.igre
<head>
<title>Arhiv iger uporabnika {{uporabnisko_ime}}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
</head>
<style>
ul{
    padding: 15px 15px;
}

span{
    margin: 5px 5px;
}
</style>
<div class="columns is-mobile is-centered">
<h1 class="subtitle is-1 " style="margin:10px;">Arhiv iger uporabnika <strong>{{uporabnisko_ime}}</strong></h1>
</div>
<div class="columns is-mobile is-centered">
<ul>
            % for posamezna_igra in vse_uporabnikove_igre:
            % id_igre, beli, crni, rez, lok_rez, igra, celoten_fen, datum = posamezna_igra
            <li class="level-left">
            <div class="button is-warning is-selected is-light" name="id_igre" value="{{posamezna_igra[id_igre]}}" style="width:300px;  color:black; border: 0.1px solid black; justify-content: center;">
                {{posamezna_igra[id_igre]}}: {{posamezna_igra[beli]}} vs. {{posamezna_igra[crni]}}
            </div>
            <a href="/arhiv/{{posamezna_igra[id_igre]}}/" class="button is-info" name="id_igre" value="{{posamezna_igra[id_igre]}}" style="width:300px; border: 0.1px solid black;">
                % if posamezna_igra[lok_rez] == "Zmaga":
                <span class="tag is-rounded" style="background-color:limegreen; color:white; border: 0.1px solid black;">{{posamezna_igra[lok_rez]}}</span>
                %end
                % if posamezna_igra[lok_rez] == "Poraz":
                <span class="tag is-rounded" style="background-color:orangered; color:white; border: 0.1px solid black;">{{posamezna_igra[lok_rez]}}</span>
                %end
                % if posamezna_igra[lok_rez] == "Remi":
                <span class="tag is-rounded" style="background-color:gray; color:white; border: 0.1px solid black;">{{posamezna_igra[lok_rez]}}</span>
                %end

                <span class="tag is-rounded" style="border: 0.1px solid black;">{{posamezna_igra[datum].split(" ")[0]}}</span>
                </a>
            % end
            % end
            </li>
</ul>
</div>

</html>