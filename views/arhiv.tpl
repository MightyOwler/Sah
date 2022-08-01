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
<head>
<title>Igranje šaha</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
</head>
<ul>
            % for posamezna_igra in vse_uporabnikove_igre:
            % id_igre, beli, crni, rez, lok_rez, igra, celoten_fen, datum = posamezna_igra
            % print(id_igre, beli, crni, rez, lok_rez, igra, celoten_fen, datum)
            <li class="level-left">
            <div class="button is-primary is-selected" name="id_igre" value="{{posamezna_igra[id_igre]}}">
                {{posamezna_igra[id_igre]}}: {{posamezna_igra[beli]}} vs. {{posamezna_igra[crni]}}
                <!--- <span class="tag is-rounded">{{posamezna_igra[lok_rez]}}</span> --->
            </div>
            <a href="/arhiv/{{posamezna_igra[id_igre]}}/" class="button" name="id_igre" value="{{posamezna_igra[id_igre]}}">
                <span class="tag is-rounded">{{posamezna_igra[lok_rez]}}</span>
                <span class="tag is-rounded">{{posamezna_igra[datum].split(" ")[0]}}</span>
                </a>
            % end
            % end
            </li>
</ul>


</html>