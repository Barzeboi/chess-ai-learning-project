extends Button

@onready var tile_map_layer: TileMapLayer = $"../../TileMapLayer"
var piece_position: Vector2i
var active_piece: bool = false
var action_points: int = 1

var valid_moves: Array = []

func _ready() -> void:
	piece_position = tile_map_layer.local_to_map(tile_map_layer.to_local(position))

func _input(event: InputEvent) -> void:
	if active_piece == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				var global_clicked: Vector2 = get_global_mouse_position()
				var pos_clicked: Vector2i = tile_map_layer.local_to_map(tile_map_layer.to_local(global_clicked))
				move_entered(pos_clicked)
				print(pos_clicked)

func _on_pressed() -> void:
	active_piece = true
	print(name + ": Active piece!")
	valid_moves = [Vector2i(piece_position.x - 1, piece_position.y - 1), 
Vector2i(piece_position.x + 1, piece_position.y - 1)]
	
func move_entered(move_position:Vector2i) -> Vector2i:
	valid_moves.clear()
	if move_position != valid_moves[0] and move_position != valid_moves[1] :
		print("Invalid Move: " + str(valid_moves[1]))
		move_position = piece_position
	else:
		piece_position = move_position
		var new_position: Vector2 = tile_map_layer.map_to_local(tile_map_layer.to_global(move_position))
		position = Vector2(new_position.x - 28, new_position.y - 28)
		
		action_points -= 1
		print(name + " new position (" + str(move_position) + ")")
	return move_position
