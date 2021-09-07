extends RigidBody2D

export(bool) var is_left
onready var TweenNode = get_node("Tween")
onready var init_rotation = self.rotation_degrees
onready var player = get_node("AudioStreamPlayer2D")

onready var action : String = "FlipperL" if is_left  else "FlipperR"
onready var rotation_target : float = init_rotation - 70 if is_left else init_rotation + 70


func _physics_process(_delta):
	if Input.is_action_just_pressed(action):
		player.play()
	if Input.is_action_pressed(action):
		TweenNode.interpolate_property(self, "rotation_degrees", null, rotation_target, 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		TweenNode.start()
	if Input.is_action_just_released(action):
		TweenNode.stop(self)
		TweenNode.interpolate_property(self, "rotation_degrees", null, init_rotation, 0.11, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
		TweenNode.start()
