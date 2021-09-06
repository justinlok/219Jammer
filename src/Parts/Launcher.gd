extends Node2D

onready var elevator = get_node("Elevator")
onready var anim_player = get_node("Elevator/AnimationPlayer")
onready var burst = get_node("Burst")
onready var tweenNode = get_node("Elevator/Tween")
func _ready():
	elevator.frame = 0
	elevator.position = Vector2(-72.29, -400)
	play_entrance()

func play_entrance():
	tweenNode.interpolate_property(elevator, "position:y", -400, 546, 5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	anim_player.play("crystal")
	tweenNode.start()
