extends Node2D

export var elevator_length : float = 220

onready var animation_player : AnimationPlayer = get_node("Elevator/AnimationPlayer")
onready var tween : Tween = get_node("Elevator/Tween")

var input_lock : bool = true

func _ready():
	$Elevator.frame = 0
	_play_reload()

func _play_reload():
	tween.interpolate_property($Elevator, "position:y", null, elevator_length, 1.4, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	animation_player.play("crystal")
	tween.start()
	
func _play_fire():
	tween.interpolate_property($Elevator, "position:y", null, 0, 0.25, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	animation_player.play("crystal")
	tween.start()

func _input(event):
	if input_lock:
		return

	var balls = []
	for body in $BallDetection.get_overlapping_bodies():
		if body is Ball:
			balls.append(body)

	if event.is_action("Launch"):
		#for ball in balls:
		#	ball.set_linear_velocity(Vector2(0,-1000))
		_play_fire()


func _on_Tween_tween_all_completed():
	input_lock = !input_lock
	if input_lock:
		_play_reload()
