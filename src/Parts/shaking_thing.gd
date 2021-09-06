extends RigidBody2D
onready var bound_check = get_node("Boundary_check")
func _ready():
	connect("body_entered", self, "_on_Shaking_Thing_body_entered")

func _on_Shaking_Thing_body_entered(body):
	print("entered")
	if bound_check.overlaps_body(body):
		print("Howling noies")
