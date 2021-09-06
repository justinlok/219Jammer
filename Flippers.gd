extends RigidBody2D
onready var TweenNode = get_node("Tween")
onready var Init_rotation = self.rotation_degrees

func _process(delta):
	if Input.is_action_pressed("FlipperL"):
		TweenNode.interpolate_property(self, "rotation_degrees", null, Init_rotation-70, 0.06, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		TweenNode.start()
	if Input.is_action_just_released("FlipperL"):
		TweenNode.stop(self)
		TweenNode.interpolate_property(self, "rotation_degrees", null, Init_rotation, 0.11, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
		TweenNode.start()

