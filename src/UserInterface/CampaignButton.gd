tool

extends Button

export(String, FILE) var next_scene_path: = "res://src/Levels/Level_1.tscn"

func _on_button_up():
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path is not set" if next_scene_path == "" else ""
