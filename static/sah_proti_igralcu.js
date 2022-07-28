const board = document.querySelector('chess-board');

document.querySelector('#flipOrientationBtn').addEventListener('click', () => {
  board.flip();
});