extends RigidBody2D
class_name Ball

onready var auto_delete_y : float = OS.window_size.y

#portal linkage id
var portal_id = 0

func _integrate_forces(state):
	var xform = state.get_transform()
	if xform.origin.y > auto_delete_y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = auto_delete_y
	state.set_transform(xform)
