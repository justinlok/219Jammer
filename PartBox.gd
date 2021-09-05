extends VBoxContainer

onready var PART_BUTTON : PackedScene = preload("res://src/UserInterface/PartButton.tscn")
onready var Sandbox : Node2D = find_parent("Sandbox")
const PARTS_DIR : String = "res://src/Parts/"
var new_part : Node2D = null
var is_multiplace : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add parts to parts menu.
	var dir = Directory.new()
	dir.open(PARTS_DIR)
	dir.list_dir_begin()
	var files = []

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)
			
	dir.list_dir_end()
	print_debug("Parts list size: "  + String(files.size()))

	for file in files:
		_add_button(file)
		pass

func _process(delta):
	if  new_part != null:
		# Part ghosting when selected.
		new_part.set_position(get_viewport().get_mouse_position())

func _input(event):
	# Check key modifier.
	if event.is_action_pressed("editor_modifier"):
		is_multiplace = true
	if event.is_action_released("editor_modifier"):
		is_multiplace = false

	# Part placement & handeling.
	if new_part == null:
		return
	if event.is_action_pressed("editor_rorate_cw"):
		new_part.rotate(15 * PI / 180)
	elif event.is_action_pressed("editor_rotate_ccw"):
		new_part.rotate(-15 * PI / 180)
	elif event.is_action_pressed("editor_place"):
		if is_multiplace:
			print_debug("Pressed")
			var path : String = new_part.filename
			print_debug ("path " + path)
			_place_part()
			set_selected_part(path)
		else:
			_place_part()

func _place_part() -> void:
	new_part.set_process(true)
	new_part.modulate = Color(
		new_part.modulate.r, new_part.modulate.g, new_part.modulate.b, 1)
	new_part = null

func _add_button(file : String) -> void:
	var new_button = PART_BUTTON.instance()
	new_button.path = PARTS_DIR + file
	new_button.text = file.trim_suffix(".tscn")
	self.add_child(new_button)
	pass

func set_selected_part(path) -> void:
	new_part = load(path).instance()
	new_part.set_process(false)
	new_part.modulate = Color(
		new_part.modulate.r, new_part.modulate.g, new_part.modulate.b, 0.5)
	Sandbox.add_child(new_part)
