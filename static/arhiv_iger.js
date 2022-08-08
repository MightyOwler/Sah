celotna_igra = celotna_igra.slice(1,-1).split(", ");
const dolzina_igre = celotna_igra.length;
var polpoteza = 0;

// if ('{{str(uporabnisko_ime)}}' === '{{str(crni)}}'){
//     board.flip();
//  }

document.querySelector('#naprej').addEventListener('click', () => {
    if (polpoteza < dolzina_igre - 1){
        polpoteza += 1;
        board.setPosition(celotna_igra[polpoteza]);}
});

document.querySelector('#naprej').addEventListener('keydown', (e) => {
    e = e || window.event;
    if (e.keyCode === 39) {
    if (polpoteza < dolzina_igre - 1){
        polpoteza += 1;
        board.setPosition(celotna_igra[polpoteza]);}
  }
    
});

document.querySelector('#nazaj').addEventListener('click', () => {
    if (0< polpoteza){
        polpoteza -= 1;
        board.setPosition(celotna_igra[polpoteza]);}
});

document.querySelector('#nazaj').addEventListener('keydown', (e) => {
    e = e;
    if (e.key === 'ArrowLeft') { 
    if (0< polpoteza){
        polpoteza -= 1;
        board.setPosition(celotna_igra[polpoteza]);}
  }
    
});

// ukazi za upravljanje s tipkami

 document.onkeydown = function (event) {
      switch (event.keyCode) {
         case 37:
         case 65:
            if (0< polpoteza){ polpoteza -= 1; board.setPosition(celotna_igra[polpoteza]);};
            break;
         case 39:
         case 68:
         case 32:
            if (polpoteza < dolzina_igre - 1){polpoteza += 1;board.setPosition(celotna_igra[polpoteza]);};
            break;
        case 38:
        case 87:
            polpoteza = celotna_igra.length -1;
            board.setPosition(celotna_igra[polpoteza]);
            break;
        case 40:
        case 83:
            polpoteza = 0;
            board.setPosition(celotna_igra[polpoteza]);
            break;

      }
   };
document.querySelector('#flipOrientationBtn').addEventListener('click', () => {
  board.flip();
});