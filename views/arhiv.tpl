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
<title>Arhiv uporabnika {{uporabnisko_ime}}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.8.2/css/bulma.min.css">
</head>
<style>

ul{
  list-style-type:none;
  justify-content: center;
  text-align: center;

}
ul li{
  display: list-item;
  padding: 5px 15px;
  color:white;
}
div{
  background: wheat;
}
</style>
<ul>
            % for posamezna_igra in vse_uporabnikove_igre:
            % id_igre, beli, crni, rez, lok_rez, igra, celoten_fen, datum = posamezna_igra
            <li class="level-left">
            <div class="button is-primary is-selected" name="id_igre" value="{{posamezna_igra[id_igre]}}" style="width:200px; background-color:BurlyWood; color:black; border: 0.1px solid black; justify-content: center;">
                {{posamezna_igra[id_igre]}}: {{posamezna_igra[beli]}} vs. {{posamezna_igra[crni]}}
            </div>
            <a href="/arhiv/{{posamezna_igra[id_igre]}}/" class="button" name="id_igre" value="{{posamezna_igra[id_igre]}}" style="width:200px; border: 0.1px solid black; background-color:AliceBlue;">
                % if posamezna_igra[lok_rez] == "Zmaga":
                <span class="tag is-rounded" style="background-color:lime; color:white; border: 0.1px solid black;">{{posamezna_igra[lok_rez]}}</span>
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


</html>