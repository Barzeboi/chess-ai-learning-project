extends Node

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
var board: Board = Board.new()
var is_piece_active: bool = false
var active_piece: PackedScene
var action_points: int = 100
var enemy_piece_in_tile: bool = false
var color: String = "Black"
var piece_pos

var valid_moves: Array

func _ready() -> void:
	EventCall.send_piece.connect(_piece_picked)

func _input(event: InputEvent) -> void:
	if is_piece_active == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				var pos_clicked: Vector2 = get_viewport().get_mouse_position()
				EventCall.pick_piece.emit(color, pos_clicked)
	elif is_piece_active == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				var pos_clicked: Vector2 = get_viewport().get_mouse_position()
				var tile: Vector2i = tile_map_layer.local_to_map(tile_map_layer.to_local(pos_clicked))
				_move_entered(tile)
				
func _piece_picked(piece, piece_position):
	print(piece, piece_position)
	valid_moves.clear()
	valid_moves = [Vector2i(piece_position.x - 1, piece_position.y - 1), 
Vector2i(piece_position.x + 1, piece_position.y - 1), Vector2i(piece_position.x, piece_position.y - 2),
Vector2i(piece_position.x - 2, piece_position.y - 2)]

func _move_entered(move_position: Vector2i) -> Vector2i:
	if active_piece != null:
		is_piece_active = true
		
	if is_piece_active == true:
		if action_points > 0:
			piece_pos = move_position
			var new_position: Vector2 = tile_map_layer.map_to_local(tile_map_layer.to_global(move_position))
			action_points -= 1
			print(name + " new position (" + str(move_position) + ")")
			EventCall.send_move.emit(active_piece, move_position, valid_moves)
	return move_position
			
		
