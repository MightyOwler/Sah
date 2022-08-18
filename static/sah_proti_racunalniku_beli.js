// NOTE: this example uses the chess.js library:
// https://github.com/jhlywa/chess.js

const board = document.querySelector('chess-board');
const game = new Chess();
const pgnElement = document.querySelector('#pgn');
var celotna_igra = [];

// da bomo uvedli engine
const pieceScore = {"Q": 9, "R": 5, "B": 3, "N": 3, "P": 1, "q": -9, "r": -5, "b": -3, "n": -3, "p": -1};
const CHECKMATE = 1000;
const STALEMATE = 0;

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

function makeRandomMove() {
  let possibleMoves = game.moves();

  // game over
  if (possibleMoves.length === 0) {
    return;
  }

  //const randomIdx = Math.floor(Math.random() * possibleMoves.length);
  //game.move(possibleMoves[randomIdx]);

  AIPoteza();
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
  window.setTimeout(makeRandomMove, 250);
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

function AIPoteza(){
    if (game.turn() === 'w') {
        var turnMultiplier = 1;
      }
    else{
        var turnMultiplier = -1;
    }
    
    
    let possibleMoves = game.moves();
    var maxScore = turnMultiplier * CHECKMATE;
    var bestMove = [];
    var scores = [];
    possibleMoves.forEach((poteza) => {
        game.move(poteza);
        if (game.in_checkmate()) {
            var score = - turnMultiplier * CHECKMATE;
        }
        else if (game.in_draw()) {
            var score = STALEMATE;
        }
        else {
            
            var score = turnMultiplier * ovrednotiPozicijo();
        }
    if (score > maxScore){
        maxScore = score;
        bestMove = [poteza];
        scores.push(score);
    } 
    else if (score === maxScore) {
        bestMove.push(poteza);
    }
    game.undo();
    })
    var randomIdx = Math.floor(Math.random() * bestMove.length);
    game.move(bestMove[randomIdx]);
}

// function AIPoteza2(){
//     if (game.turn() === 'w') {
//         var turnMultiplier = 1;
//       }
//     else{
//         var turnMultiplier = -1;
//     }
    
    
//     var possibleMoves1 = game.moves();
//     var maxScore = turnMultiplier * CHECKMATE;
//     var bestMoves = [];
//     possibleMoves1.forEach((poteza1) => {
//         game.move(poteza1);
//         var possibleMoves2 = game.moves();
//         possibleMoves2.forEach((poteza2) => {
//             game.move(poteza2);
//             if (game.in_checkmate()) {
//                 var score = - turnMultiplier * CHECKMATE;
//             }
//             else if (game.in_draw()) {
//                 var score = STALEMATE;
//             }
//             else {
//                 var score = turnMultiplier * ovrednotiPozicijo();
//             }
//             if (score > maxScore){
//                 maxScore = score;
//                 bestMoves = [[poteza1, poteza2]];
//             }
//             else if (score == maxScore) {
//                 bestMoves.push([poteza1, poteza2]);
//             }
//             game.undo();
//         })
//     game.undo();
//     })
//     const randomIdx = Math.floor(Math.random() * bestMoves.length);
//     game.move(bestMoves[randomIdx][0]);
// }



// prešteje vrednost figur na šahovnici, glede na standardno točkovanje
function ovrednotiPozicijo(){
    let fen = game.fen().slice(0, game.fen().indexOf(" "));
    var vrednost = 0;
    for (let i = 0; i < fen.length; i++) {
        if (fen[i] in pieceScore){
            vrednost += pieceScore[fen[i]];
        }  
      }
    return vrednost;

}

updateStatus(); 