extends RigidBody2D

onready var autodelete_y : float = OS.window_size.y


#func _process(delta):
#
#	# Delete ball if falls off screen and loop disabled
#	if self.position.y > autodelete_y:
#		if get_parent().get("looping"):
#			self.position.y = 0
#		else:
#			self.queue_free()

#portal linkage id
var portal_id = 0

func _integrate_forces(state):
	var xform = state.get_transform()
	if xform.origin.y > autodelete_y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = autodelete_y
	state.set_transform(xform)
