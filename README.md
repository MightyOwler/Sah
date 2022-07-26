# Projektna naloga - šah



Šah je ena izmed najstarejših in najbolj priljubljenih iger na svetu. Igrata jo dva igralca, ki izmenično premikata vsak svoje figure s ciljem matirati nasprotnikovega kralja.

Čeprav so pravila šaha preprosta, se v njem skriva izredna globina, ki privlači stotine milijonov igralcev po vsem svetu.

![slika šaha](https://img.freepik.com/premium-vector/realistic-chess-pieces-chessboard-set_208581-1470.jpg?w=2000)

**Opomba:** Zgornja slika je sicer zelo lepa, bi pa moralo biti polje a1 črne barve.

Ker šah igram že dolgo časa, sem se odločil, da za projektno nalogo pri predmetu uvod v programiranje napišem spletno storitev, s pomočjo katere lahko uporabnik igra šah.

## Opis programa
Program nam omogoča igranje šaha prek spletnega vmesnika. Najprej se moramo registrirati, nato pa še prijaviti. Tedaj lahko:
- Igramo šah proti lokalnemu nasprotniku (*če za nasprotnika izberemo ime kakšnega uporabnika, se bo igra shranila tudi na njegovem računu!*)
- Igramo šah proti računalniku (*trenutno sta na voljo računalnik, ki vleče naključno, in računalnik z globino 3*)
- Odpremo arhiv iger, kjer lahko prevrtimo odigrane igre od začetka do konca (*pozicijo spreminjamo s puščicami ali tipkami WASD*)
- Pregledamo statistiko svojih odigranih iger

## Kako zagnati program?
1. Iz repozitorija na računalnik prenesite zip datoteko. Če imate naložen `git`, lahko to enostavno storite v terminalu z ukazom `git clone https://github.com/MightyOwler/Sah`.
2. V mapi, kjer se nahaja datoteka `spletni_vmesnik.py`, ustvarite novo datoteko z imenom `skrivnost.txt` in vanjo vpišite poljubno kratko besedilo.
3. Iz terminala poženite ukaz `python spletni_vmesnik.py` in odprite [lokalni strežnik](http://localhost:8080/).

**Opozorilo:** Nekateri antivirusni programi lahko povzročajo težave pri uporabi programa. Odpravite jih lahko tako, da antivirusne programe začasno izklopite v nastavitvah brskalnika.

## Viri in ostale povezave
Pri izdelavi spletne storitve sem si izposodil naslednje slike:
1. Opica Stanley (https://www.chess.com/member/stanley1)
2. Stockfish (https://stockfishchess.org/)
3. Ikona šahovnice (https://freeicons.io/common-styles-icons-3/chess-icon-10622)
4. Slika šaha na datoteki README (https://img.freepik.com/premium-vector/realistic-chess-pieces-chessboard-set_208581-1470.jpg)

Program za pravilno delovanje uporablja JavaScript knjižnice [chess.js](https://github.com/jhlywa/chess.js/blob/master/README.md), [chessboard-element.js](https://justinfagnani.github.io/chessboard-element/) in [chart.js](https://www.chartjs.org/). Za lep izgled pa sta bila uporabljena [Bulma](https://bulma.io/) in [Font Awesome](https://fontawesome.com/icons).

