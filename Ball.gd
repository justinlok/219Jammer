extends RigidBody2D

onready var autodelete_y : float = OS.window_size.y

func _process(delta):
	
	# Delete ball if falls off screen and loop disabled
	if self.position.y > autodelete_y:
		if get_parent().get("looping"):
			self.position.y = 0
		else:
			self.queue_free()
