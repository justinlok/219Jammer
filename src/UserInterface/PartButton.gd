extends Button

var path : String = ""


func _on_PartButton_pressed():
	get_parent().selected_part_path = path
