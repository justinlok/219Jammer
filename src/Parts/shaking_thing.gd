extends RigidBody2D
onready var bound_check = get_node("Boundary_check")
export (int) var bumper_strength
onready var direction = Vector2(cos(deg2rad(rotation_degrees-31)),sin(deg2rad(rotation_degrees-31)))
func _ready():
	connect("body_entered", self, "_on_Shaking_Thing_body_entered")

func _on_Shaking_Thing_body_entered(body):
	print("entered")
	if bound_check.overlaps_body(body):
		print("Howling noies")
		body.set_linear_velocity(10*bumper_strength*direction.normalized())
