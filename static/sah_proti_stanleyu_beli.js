// NOTE: this example uses the chess.js library:
// https://github.com/jhlywa/chess.js
//
const board = document.querySelector('chess-board');
const game = new Chess();
const pgnElement = document.querySelector('#pgn');


board.addEventListener('drag-start', (e) => {
  const {source, piece, position, orientation} = e.detail;

  // do not pick up pieces if the game is over
  if (game.game_over()) {
    e.preventDefault();
    return;
  }

  // only pick up pieces for White
  if (piece.search(/^b/) !== -1) {
    e.preventDefault();
    return;
  }
});

function makeRandomMove () {
  let possibleMoves = game.moves();

  // game over
  if (possibleMoves.length === 0) {
    return;
  }

  const randomIdx = Math.floor(Math.random() * possibleMoves.length);
  game.move(possibleMoves[randomIdx]);
  board.setPosition(game.fen());
  updateStatus();
 
}

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
    return;
  }

  updateStatus();
  // make random legal move for black
  window.setTimeout(makeRandomMove, 250);
  updateStatus();

});

// update the board position after the piece snap
// for castling, en passant, pawn promotion
board.addEventListener('snap-end', (e) => {
  board.setPosition(game.fen());
});

function updateStatus () {
  let moveColor = 'White';
  if (game.turn() === 'b') {
    moveColor = 'Black';
  }
  
  if (game.in_checkmate()) {
  // checkmate?
  var rezulat_na_koncu_pgn
  if (moveColor == "Black") {var rezulat_na_koncu_pgn = " 1-0"}
  else {var rezulat_na_koncu_pgn = " 0-1"}
  location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).concat(";").replace("#","_").concat("?"));
} else if (game.in_draw()) {
  // draw?
  var rezulat_na_koncu_pgn = " 1/2-1/2"
  location.replace('/shrani_igro/?igra='.concat(String(game.pgn())).concat(rezulat_na_koncu_pgn).concat(";").replace("#","_"));
}
pgnElement.innerHTML = game.pgn();
}

updateStatus(); 