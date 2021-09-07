extends Area2D
export (int) var bumper_strength
export (int) var score

onready var big : Vector2 = $Sprite.scale*1.5
onready var small : Sprite = $Sprite.duplicate(true)

func _light_up():
	$Tween.interpolate_property($Sprite, "scale", big, small.scale, 0.1, $Tween.TRANS_ELASTIC, $Tween.EASE_OUT, 0)
	$Tween.start()
	$AudioStreamPlayer2D.play()


func _on_Bumper_body_entered(body):
	var new_angle = body.global_position - self.global_position
	small = $Sprite.duplicate(true)
	big = $Sprite.scale*1.5
	var body_speed = sqrt(pow(body.get_linear_velocity().x,2)+pow(body.get_linear_velocity().y,2))
	if body_speed > bumper_strength*10:
		body.set_linear_velocity(body_speed*new_angle.normalized())
	else:
		body.set_linear_velocity(10*bumper_strength*new_angle.normalized())

	_light_up()
