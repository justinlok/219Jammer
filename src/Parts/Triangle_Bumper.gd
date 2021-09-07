extends Area2D

export (int) var bumper_strength
export (int) var score
onready var player = get_node("AudioStreamPlayer2D")
func _light_up():
	pass

func _on_Triangle_Bumper_body_entered(body):
	var direction = (body.position-self.position).normalized()
	if $Bottom.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees+90)),sin(deg2rad(rotation_degrees+90)))
	elif $Right.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees-30)),sin(deg2rad(rotation_degrees-30)))
	else:
		direction = Vector2(cos(deg2rad(rotation_degrees-150)),sin(deg2rad(rotation_degrees-150)))
	body.set_linear_velocity(10*bumper_strength*direction.normalized())
	player.play()

