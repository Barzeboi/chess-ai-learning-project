extends Button

@onready var tile_map_layer: TileMapLayer = $"../../TileMapLayer"
var board_data: Board = Board.new()
var piece_position: Vector2i
var enemy_piece_in_tile: bool = false
var active_piece
var action_points

var valid_moves: Array


func _ready() -> void:
	piece_position = tile_map_layer.local_to_map(tile_map_layer.to_local(position))
	board_data.Pieces.append([self, piece_position])
		
				

#func _on_pressed() -> void:
	#valid_moves.clear()
	#active_piece = true
	#print(name + ": Active piece!")
	#valid_moves = [Vector2i(piece_position.x - 1, piece_position.y - 1), 
#Vector2i(piece_position.x + 1, piece_position.y - 1), Vector2i(piece_position.x, piece_position.y - 2),
#Vector2i(piece_position.x - 2, piece_position.y - 2)]


func _check_for_pieces() -> void:
	for i in board_data.Pieces:
		if board_data.Pieces[i][1] == valid_moves[0] or board_data.Pieces[i][1] == valid_moves[1]:
			enemy_piece_in_tile = true
func _move_entered(move_position:Vector2i) -> Vector2i:
	active_piece = false
	if action_points > 0:
		if move_position == valid_moves[0] or move_position == valid_moves[1] :
			piece_position = move_position
			var new_position: Vector2 = tile_map_layer.map_to_local(tile_map_layer.to_global(move_position))
			set_position(Vector2(new_position.x - 28, new_position.y - 28))
			action_points -= 1
			print(name + " new position (" + str(move_position) + ")")
		elif move_position == valid_moves[2] and enemy_piece_in_tile:
			pass
		else:
			print("Invalid Move: " + str(valid_moves[1]))
			move_position = piece_position
	return move_position
	
func _capture(piece) -> void:
	pass
