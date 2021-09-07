extends Node2D

onready var animation_player : AnimationPlayer = get_node("Elevator/AnimationPlayer")
onready var tween : Tween = get_node("Elevator/Tween")

func _ready():
	$Elevator.frame = 0
	$Elevator.position = Vector2(-30.32, -84.731)

	play_entrance()

func play_entrance():
	var end = 329.613
	tween.interpolate_property($Elevator, "position:y", null, end, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	animation_player.play("crystal")
	tween.start()

func _input(event):
	var balls = []
	for body in $BallDetection.get_overlapping_bodies():
		if body is Ball:
			balls.append(body)

	if event.is_action("Launch"):
		for ball in balls:
			ball.set_linear_velocity(Vector2(0,-1000))
