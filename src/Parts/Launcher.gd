extends Node2D

onready var elevator = get_node("Elevator")
onready var anim_player = get_node("Elevator/AnimationPlayer")
onready var tweenNode = get_node("Elevator/Tween")
var launch_ready = false
func _ready():
	elevator.frame = 0
	elevator.position = Vector2(-30.32, -84.731)

	play_entrance()

func play_entrance():
	var end = 329.613
	tweenNode.interpolate_property(elevator, "position:y", null, end, 2.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	anim_player.play("crystal")
	tweenNode.start()

func _input(event):
	var balls = []
	for body in $BallDetection.get_overlapping_bodies():
		if body is Ball:
			balls.append(body)

	if event.is_action("Launch"):
		for ball in balls:
			ball.set_linear_velocity(Vector2(0,-1000))

func _on_Tween_tween_all_completed():
	launch_ready = true
