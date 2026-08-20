This Score effects how the minimax system views a score given to it, it will choose a score based on how advantageous it is to the AI

1. Move places the piece one spot away from a opponent piece: -10 for each opponent piece
2. Move gets close to the opponent's end of the board: +1 * how close you are
3. Move Captures a piece: + 5 for each opponent piece
4. How many pieces AI has left: +1
5. How many pieces opponent has left: -1