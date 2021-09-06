extends Area2D
export (int) var bumper_strength
export (int) var score

onready var sprite = get_node("Sprite")
onready var tween = get_node("Tween")
onready var big = sprite.scale*1.5
onready var small = sprite.duplicate(true)
onready var player = get_node("AudioStreamPlayer2D")
func light_up():
	
	tween.interpolate_property(sprite, "scale", big, small.scale, 0.1, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0)
	tween.start()
	player.play()


func _on_Bumper_body_entered(body):
	var new_angle = body.position - self.position
	small = sprite.duplicate(true)
	big = sprite.scale*1.5
	var body_speed = sqrt(pow(body.get_linear_velocity().x,2)+pow(body.get_linear_velocity().y,2))
	if body_speed > bumper_strength*10:
		body.set_linear_velocity(body_speed*new_angle.normalized())
	else:
		body.set_linear_velocity(10*bumper_strength*new_angle.normalized())
	
	light_up()
