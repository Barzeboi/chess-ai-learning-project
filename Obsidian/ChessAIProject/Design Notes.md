1. The Game will have a Action -> Board -> Piece code structure, so that only the board has to interact with multiple scripts.
2. The Player and AI will always be the same colors (black for player, red for AI)
3. The Player and AI decisions will be handle mostly as the same by the board, this is to make sure they are operating under similar rules
4. Both Player and AI will have to capture a piece if there is a move available that results in a captured piece. 