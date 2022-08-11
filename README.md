# Projektna naloga - šah



Šah je ena izmed najstarejših in najbolj priljubljenih iger na svetu. Igrata jo dva igralca, ki izmenično premikata vsak svoje figure s ciljem matirati nasprotnikovega kralja.

Čeprav so pravila šaha izredno preprosta, se v njem skirva izredna globina, ki privlači stotine miljonov igralcev po vsem svetu.

![slika šaha](https://img.freepik.com/premium-vector/realistic-chess-pieces-chessboard-set_208581-1470.jpg?w=2000)

Ker šah igram že dolgo časa, sem se odločil, da za projektno nalogo pri predmetu uvod v programiranje napišem spletno storitev, s pomočjo katere lahko uporabnik igra šah.

## Opis programa
Program nam omogoča igranje šaha s spletnim vmesnikom. Najprej se moramo registrirati, nato pa še prijaviti. Tedaj lakho:
- Igramo proti lokalnemu nasprotniku
- Igramo proti računalniku (trenutno je na voljo zgolj računalnik, ki naključno vleče poteze)
- Odpremo arhiv iger, kjer lahko prevrtimo odigrane igre od začetka do konca
- Pregledamo statistiko svojih odigranih iger

## Kako program zagnati?
1. Iz repozitorija na računalnik prenesite zip datoteko. Če imate naložen `git`, lahko to enostavno storite v terminalu z ukazom `git clone https://github.com/MightyOwler/Sah`.
2. V mapi, kjer se nahaja datoteka `spletni_vmesnik.py`, ustvarite novo datoteko z imenom `skrivnost.txt` in vanjo vpišite poljubno kratko besedilo.
3. Iz terminala poženite ukaz `python spletni_vmesnik.py` in odprite [lokalni strežnik](http://localhost:8080/).


## Viri in ostale povezave
Pri izdelavi spletne storitve sem si sposodil nasledje slike:
1. Opica Stanley (https://www.chess.com/member/stanley1)
2. Stockfish (https://stockfishchess.org/)
3. Ikona šahovnice (https://freeicons.io/common-styles-icons-3/chess-icon-10622)
4. Slika šaha na README (https://img.freepik.com/premium-vector/realistic-chess-pieces-chessboard-set_208581-1470.jpg?w=2000)

Pogram za pravilno delovanje knjižnice [chess.js](https://github.com/jhlywa/chess.js/blob/master/README.md), [chessboard-element.js](https://justinfagnani.github.io/chessboard-element/) in [chart.js](https://www.chartjs.org/). Za lep izled pa sta bili uporabljena [Bulma](https://bulma.io/) in [Font Awesome](https://fontawesome.com/icons).

