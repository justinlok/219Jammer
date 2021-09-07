extends Area2D

export (int) var bumper_strength
export (int) var score

func _light_up():
	$AudioStreamPlayer2D.play()

func _on_Square_Bumper_body_entered(body):
	var direction = (body.position-self.position).normalized()
	if $Top.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees-90)),sin(deg2rad(rotation_degrees-90)))
	elif $Left.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees+180)),sin(deg2rad(rotation_degrees+180)))
	elif $Right.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees)),sin(deg2rad(rotation_degrees)))
	else:
		direction = Vector2(cos(deg2rad(rotation_degrees+90)),sin(deg2rad(rotation_degrees+90)))
	body.set_linear_velocity(10*bumper_strength*direction.normalized())
	_light_up()
