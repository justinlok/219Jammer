extends Node2D

onready var elevator = get_node("Elevator")
onready var anim_player = get_node("Elevator/AnimationPlayer")
onready var burst = get_node("Ball/Burst")
onready var ball = get_node("Ball")
onready var ball_tweenNode = get_node("Ball/Tween")
onready var tweenNode = get_node("Elevator/Tween")
var launch_ready = false
func _ready():
	elevator.frame = 0
	ball.set_mode(1)
	elevator.position = Vector2(-30.32, -84.731)
	ball.position = Vector2(0.556, -185)
	burst.visible = false
	play_entrance()

func play_entrance():
	var end = 329.613
	var difference = elevator.position.y - ball.position.y
	tweenNode.interpolate_property(elevator, "position:y", null, end, 5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	anim_player.play("crystal")
	ball_tweenNode.interpolate_property(ball, "position:y", null, end-difference, 5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tweenNode.start()
	ball_tweenNode.start()

func _input(event):
	if event.is_action("Launch") and launch_ready:
		ball.set_mode(0)
		ball.set_linear_velocity(Vector2(0,-1000))
		launch_ready = false

func _on_Tween_tween_all_completed():
	launch_ready = true
