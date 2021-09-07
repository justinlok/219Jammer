extends Node

signal score_updated
signal player_died

var score: = 0 setget set_score
var balls: = 3 setget set_balls

func reset() -> void:
	score = 0
	balls = 3
	emit_signal("score_updated")

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func add_score(value: int) -> void:
	score += value
	emit_signal("score_updated")

func set_balls(value: int) -> void:
	balls = value
	emit_signal("game_over")

func check_ball() -> bool:
	balls -= 1
	if balls < 0:
		emit_signal("player_died")
		reset()
		return false
	return true
