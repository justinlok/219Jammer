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


func teleport(area):
	for portal in get_tree().get_nodes_in_group("portal"):
		if(portal != area):
			if(portal.id == area.id):
				if(!portal.lock_portal):
					area.do_lock()
					global_position = portal.global_position
					
func _on_hitbox_area_entered(area):
		if(area.is_in_group("portal")):
			if(!area.lock_portal):
				teleport(area)

#func _on_hitbox_body_entered(body):
#	if(body.is_in_group("portal")):
#			if(!body.lock_portal):
#				teleport(body)
