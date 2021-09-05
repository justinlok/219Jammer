extends Button

var path : String = ""


func _on_PartButton_pressed():
	get_parent().set_selected_part(path)
