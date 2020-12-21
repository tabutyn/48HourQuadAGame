extends Node

signal score_updated
signal player_died


var score = 0 setget set_score
var health = 0

func get_score():
	return score

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
	
	
func reset() -> void:
	score = 0
	
