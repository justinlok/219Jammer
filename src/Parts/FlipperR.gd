extends RigidBody2D
onready var TweenNode = get_node("Tween")
onready var Init_rotation = self.rotation_degrees
onready var player = get_node("AudioStreamPlayer2D")

func _physics_process(_delta):
	if Input.is_action_just_pressed("FlipperR"):
		player.play()
	if Input.is_action_pressed("FlipperR"):
		TweenNode.interpolate_property(self, "rotation_degrees", null, Init_rotation+70, 0.06, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		TweenNode.start()
	if Input.is_action_just_released("FlipperR"):
		TweenNode.stop(self)
		TweenNode.interpolate_property(self, "rotation_degrees", rotation_degrees, Init_rotation, 0.11, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
		TweenNode.start()
