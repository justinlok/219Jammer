extends Area2D
export (int) var bumper_strength
export (int) var score
onready var Top_check = get_node("Top")
onready var Left_check = get_node("Left")
onready var Right_check = get_node("Right")
onready var Bottom_check = get_node("Bottom")
onready var player = get_node("AudioStreamPlayer")
func light_up():
	player.play()


func _on_Square_Bumper_body_entered(body):
	var direction = (body.position-self.position).normalized()
	if Top_check.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees-90)),sin(deg2rad(rotation_degrees-90)))
	elif Left_check.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees+180)),sin(deg2rad(rotation_degrees+180)))
	elif Right_check.overlaps_body(body):
		direction = Vector2(cos(deg2rad(rotation_degrees)),sin(deg2rad(rotation_degrees)))
	else:
		direction = Vector2(cos(deg2rad(rotation_degrees+90)),sin(deg2rad(rotation_degrees+90)))
	body.set_linear_velocity(10*bumper_strength*direction.normalized())
	light_up()

