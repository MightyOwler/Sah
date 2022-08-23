// NOTE: this example uses the chess.js library:
// https://github.com/jhlywa/chess.js

const board = document.querySelector('chess-board');
const game = new Chess();
const pgnElement = document.querySelector('#pgn');
var celotna_igra = [];
var nextMove = null; // zato, ker je težko delati z globalnimi spremenljivkami

// da bomo uvedli engine
const pieceScore = {"Q": 9, "R": 5, "B": 3, "N": 3, "P": 1, "q": -9, "r": -5, "b": -3, "n": -3, "p": -1};
const CHECKMATE = 1000;
const STALEMATE = 0;
const GLOBINA = 3; // to dela v teoriji, v praksi pa za vse večje od 3 dela zelo počasi

board.addEventListener('drag-start', (e) => {
  const { source, piece, position, orientation } = e.detail;

  // do not pick up pieces if the game is over
  if (game.game_over()) {
    e.preventDefault();
    return;
  }

  // only pick up pieces for White
  if (piece.search(/^B/) !== -1) {
    e.preventDefault();
    return;
  }
});

function makeNegamaxMove() {
  let possibleMoves = game.moves();

  // game over
  if (possibleMoves.length === 0) {
    return;
  }

  AIPotezaNegaMax();
  board.setPosition(game.fen());
  updateStatus();
}

board.addEventListener('drop', (e) => {
  const { source, target, setAction } = e.detail;

  // see if the move is legal
  const move = game.move({
    from: source,
    to: target,
    promotion: 'q' // NOTE: always promote to a queen for example simplicity
  });

  // illegal move
  if (move === null) {
    setAction('snapback');
    return;
  } else { updateStatus(); }
  // make random legal move for black
  window.setTimeout(makeNegamaxMove, 250);
  //updateStatus();

});

// update the board position after the piece snap
// for castling, en passant, pawn promotion
board.addEventListener('snap-end', (e) => {
  board.setPosition(game.fen());
});

function updateStatus() {
  celotna_igra.push(game.fen());

  let moveColor = 'White';
  if (game.turn() === 'b') {
    moveColor = 'Black';
  }

  if (game.in_checkmate()) {
    // checkmate?
    var rezulat_na_koncu_pgn
    if (moveColor == "Black") { alert("Zmaga!!! Igra se bo shranila!"); var rezulat_na_koncu_pgn = " 1-0" }
    else { alert("Več sreče prihodnjič! Igra se bo shranila!"); var rezulat_na_koncu_pgn = " 0-1" }

    location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).replace("#", "_").concat("&fen=").concat(String(celotna_igra).replace("/", "_")));
  } else if (game.in_draw()) {
    // draw?
    var rezulat_na_koncu_pgn = " 1/2-1/2"
    alert("Remi! Igra se bo shranila!")
    location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).replace("#", "_").concat("&fen=").concat(String(celotna_igra).replace("/", "_")));
  }
  pgnElement.innerHTML = game.pgn();

}

function popravi_pozezo() {
  if (celotna_igra.length > 1) {
    game.undo();
    game.undo();
    celotna_igra.pop();
    celotna_igra.pop();
    board.setPosition(celotna_igra[celotna_igra.length - 1]);
    pgnElement.innerHTML = game.pgn();
  }
}

document.querySelector('#undo').addEventListener('click', () => {
  popravi_pozezo();
});


// Pomožna funkcija, ki pokliče rekurzivno funckijo NajdiNegaMax()
function AIPotezaNegaMax(){
    nextMove = [];
    if (game.turn() === 'w') {
        var beliNaPotezi = 1;
      }
    else{
        var beliNaPotezi = -1;
    }
    NajdiNegaMax(GLOBINA, beliNaPotezi, -CHECKMATE, CHECKMATE);
    // v primeru da ne najde ustrezne poteze, zgolj naključno premakne (prepreči bugge)
    // z length je treba narediti zato, ker nextMove ni string (ampak objekt)
    if (nextMove.length === 0){
        var randomIdx = Math.floor(Math.random() * game.moves().length);
        game.move(game.moves()[randomIdx]);
    }
    else{
        var randomIdx = Math.floor(Math.random() * nextMove.length);
        game.move(nextMove[randomIdx]);
    }
    
}


function NajdiNegaMax(globina, turnMultiplier, alpha, beta){
    if (globina === 0){
        return turnMultiplier * ovrednotiPozicijo();
    }
    
    // - 1 zato, da če je mat neizbežen, vseeno potegne (prepreči bug)
    var maxScore = -CHECKMATE - 1;
        // Zmešati je treba zato, da računalnik igra raznoliko
        let possibleMoves = shuffle(game.moves());
        try{
        possibleMoves.forEach((poteza) => {
            game.move(poteza);
            var score = - NajdiNegaMax(globina - 1, -turnMultiplier, -beta, -alpha)
            
            if (score > maxScore){
                maxScore = score;
                if (globina === GLOBINA){
                    nextMove = [poteza];
                }
            }
            game.undo();
            if (maxScore > alpha){
                alpha = maxScore;
            }
            if (alpha >= beta){
                throw "break";
            }
        })
    
    return maxScore;
        }
        catch (e) {
            if (e !== "break") throw e
          }
}



// Prešteje vrednost figur na šahovnici, glede na standardno točkovanje
// To je seveda naivna metoda, da se jo izboljšati
function ovrednotiPozicijo(){
    if (game.in_checkmate()) {
        if (game.turn() === 'w') {
            return -CHECKMATE;
          }
        else{
            return CHECKMATE;
        }
    }
    else if (game.in_draw()) {
        return STALEMATE;
    }
    else{
    let fen = game.fen().slice(0, game.fen().indexOf(" "));
    var vrednost = 0;
    for (let i = 0; i < fen.length; i++) {
        if (fen[i] in pieceScore){
            vrednost += pieceScore[fen[i]];
        }
    }  
    }
    return vrednost;

}

function shuffle(array) {
    let currentIndex = array.length,  randomIndex;
  
    // While there remain elements to shuffle.
    while (currentIndex != 0) {
  
      // Pick a remaining element.
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
  
      // And swap it with the current element.
      [array[currentIndex], array[randomIndex]] = [
        array[randomIndex], array[currentIndex]];
    }
  
    return array;
  }

updateStatus(); 