extends Node

var scores: Array[int] = [2, 12 , 19, 7, 10, 21, 4, 17]
var tree_depth: int = int(log(len(scores) / log(2)))

func _ready() -> void:
	print(_minimax(0, 0, false, scores, tree_depth))

func _minimax(cur_depth: int, node_index: int, max_turn: bool, scores: Array[int], target_depth: int):
	if target_depth == cur_depth:
		return scores[node_index]
	
	if max_turn:
		return max(
			_minimax(cur_depth + 1, node_index * 2, false, scores, target_depth),
			_minimax(cur_depth + 1, node_index * 2 + 1, false, scores, target_depth)
		)
	else:
		return min(
			_minimax(cur_depth + 1, node_index * 2, true, scores, target_depth),
			_minimax(cur_depth + 1, node_index * 2 + 1, true, scores, target_depth)
		)
