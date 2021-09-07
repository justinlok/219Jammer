extends RigidBody2D

export(bool) var is_left

onready var init_rotation : float = self.rotation_degrees
onready var action : String = "FlipperL" if is_left  else "FlipperR"
onready var rotation_target : float = init_rotation - 70 if is_left else init_rotation + 70


func _physics_process(_delta):
	if Input.is_action_just_pressed(action):
		$AudioStreamPlayer2D.play()
	if Input.is_action_pressed(action):
		$Tween.interpolate_property(self, "rotation_degrees", null, rotation_target, 0.07, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		$Tween.start()
	if Input.is_action_just_released(action):
		$Tween.stop(self)
		$Tween.interpolate_property(self, "rotation_degrees", null, init_rotation, 0.07, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
		$Tween.start()
