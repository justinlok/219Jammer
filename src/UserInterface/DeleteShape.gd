extends Area2D

var is_delete_mode : bool = false

func _input(event):
	if event.is_action_pressed("editor_delete"):
		is_delete_mode = true
		self.visible = true
	if event.is_action_released("editor_delete"):
		is_delete_mode = false
		self.visible = false


func _on_DeleteShape_input_event(viewport, event, shape_idx):
	if is_delete_mode && event.is_pressed():
		get_parent().queue_free()

