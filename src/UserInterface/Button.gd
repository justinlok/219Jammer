extends Button


onready var bg_1 : Sprite = get_parent().get_parent().get_parent().get_node("Background")
onready var bg_2 : Sprite = get_parent().get_parent().get_parent().get_node("Background2")
onready var bg_3 : Sprite = get_parent().get_parent().get_parent().get_node("Background3")


func _on_Button_button_up():
	if bg_1.visible:
		bg_1.visible = false
		bg_2.visible = true
	elif bg_2.visible:
		bg_2.visible = false
		bg_3.visible = true
	elif bg_3.visible:
		bg_3.visible = false
		bg_1.visible = true
	pass # Replace with function body.
