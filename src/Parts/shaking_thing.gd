extends RigidBody2D
onready var bound_check = get_node("Boundary_check")
onready var audio = get_node("AudioStreamPlayer2D")
export (int) var bumper_strength


func _ready():
	connect("body_entered", self, "_on_Shaking_Thing_body_entered")

func _on_Bumper_box_body_entered(body):
	if bound_check.overlaps_body(body):
		var flip = self.scale.x/abs(self.scale.x) #account for flipping horizontally
		var direction = Vector2(cos(deg2rad(rotation_degrees+flip*61)),sin(deg2rad(rotation_degrees+flip*61)))
		audio.play()
		body.set_linear_velocity(10*bumper_strength*direction.normalized())
