extends Area2D
export (int) var bumper_strength

func light_up():
	pass


func _on_Bumper_body_entered(body):
	var new_angle = body.position - self.position
	body.set_linear_velocity(10*bumper_strength*new_angle.normalized())
