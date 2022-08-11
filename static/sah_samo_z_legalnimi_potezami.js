import {objToFen} from "https://unpkg.com/chessboard-element?module";  //tole ne dela tako kot bi moralo

            // Begin Example JS
            // NOTE: this example uses the chess.js library:
// https://github.com/jhlywa/chess.js

const board = document.querySelector('chess-board');
const game = new Chess();
// const statusElement = document.querySelector('#status');
// const fenElement = document.querySelector('#fen');
const pgnElement = document.querySelector('#pgn');
var celotna_igra = [];

board.addEventListener('drag-start', (e) => {
  const {source, piece, position, orientation} = e.detail;

  // do not pick up pieces if the game is over
  if (game.game_over()) {
    e.preventDefault();
    return;
  }

  // only pick up pieces for the side to move
  if ((game.turn() === 'w' && piece.search(/^b/) !== -1) ||
      (game.turn() === 'b' && piece.search(/^w/) !== -1)) {
    e.preventDefault();
    return;
  }
});

board.addEventListener('drop', (e) => {
  const {source, target, setAction} = e.detail;

  // see if the move is legal
  const move = game.move({
    from: source,
    to: target,
    promotion: 'q' // NOTE: always promote to a queen for example simplicity
  });

  // illegal move
  if (move === null) {
    setAction('snapback');
  } else {updateStatus();}

  
});

// update the board position after the piece snap
// for castling, en passant, pawn promotion
board.addEventListener('snap-end', (e) => {
  board.setPosition(game.fen());
});

function updateStatus () {
  
  celotna_igra.push(game.fen());

  let status = '';

  let moveColor = 'White';
  if (game.turn() === 'b') {
    moveColor = 'Black';
  }

  if (game.in_checkmate()) {
    // checkmate?
    status = `Game over, ${moveColor} is in checkmate.`;
    //document.cookie = "igra=".concat(String(game.pgn()).concat(";path=/;max-age=60;Secure;"))
    var rezulat_na_koncu_pgn
    if (moveColor == "Black") {alert("Beli je zmagal!!! Igra se bo shranila!"); var rezulat_na_koncu_pgn = " 1-0"}
    else {alert("Črni je zmagal!!! Igra se bo shranila!"); var rezulat_na_koncu_pgn = " 0-1"}
    
    location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).replace("#","_").concat("&fen=").concat(String(celotna_igra).replace("/","_")));
  } else if (game.in_draw()) {
    // draw?
    status = 'Game over, drawn position';
    var rezulat_na_koncu_pgn = " 1/2-1/2"
    alert("Remi! Igra se bo shranila!")
    location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).replace("#","_").concat("&fen=").concat(String(celotna_igra).replace("/","_")));
  } else {
    // game still on
    status = `${moveColor} to move`;

    // check?
    if (game.in_check()) {
      status += `, ${moveColor} is in check`;
    }
  }

  // statusElement.innerHTML = status;
  // fenElement.innerHTML = game.fen();
  pgnElement.innerHTML = game.pgn();

  // alert(game.pgn());
  // v game.pgn() se skiriva cela igra, ko je mat bi lahko program sporočil
}

function popravi_pozezo(){
  if (celotna_igra.length > 1){
  game.undo();
  celotna_igra.pop();
  board.setPosition(celotna_igra[celotna_igra.length -1]);
  pgnElement.innerHTML = game.pgn();
  }
}

document.querySelector('#undo').addEventListener('click', () => {
  popravi_pozezo();
});

document.querySelector('#flipOrientationBtn').addEventListener('click', () => {
  board.flip();
});

updateStatus();
            // End Example JS