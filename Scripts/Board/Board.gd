extends Node;
class_name Board;

@onready var tile_map_layer: TileMapLayer = $TileMapLayer;

static var Pieces: Array = [];

func _ready() -> void:
	EventCall.pick_piece.connect(_player_pick_piece);
	EventCall.send_move_to_board.connect(_move_piece);

func _player_pick_piece(color:String, position: Vector2) -> void:
	
	var tile_clicked: Vector2i = tile_map_layer.local_to_map(tile_map_layer.to_local(position))
	Pieces.sort_custom(func (a,b): return a[1] == tile_clicked)
	var piece = Pieces[0][0]
	var piece_pos = Pieces[0][1]
	print(piece, tile_clicked)
	if piece_pos == tile_clicked:
		if piece.is_in_group(color):
			EventCall.send_piece.emit(Pieces[0][0], Pieces[0][1])

func _ai_pick_piece():
	pass
	
func _move_piece(piece, move_position, valid_moves):
	var piece_pos: Vector2i = tile_map_layer.local_to_map(tile_map_layer.to_local(piece.position))
	if move_position == valid_moves[0] or move_position == valid_moves[1]:
		piece_pos = move_position
		var new_pos: Vector2 = tile_map_layer.map_to_local(tile_map_layer.to_global(move_position))
		piece.set_position(Vector2(new_pos.x - 28, new_pos.y - 28))
		print("move to " + str(move_position))
	else:
		print("Invalid Move: " + str(valid_moves[1]))
		move_position = piece_pos
	
