extends VBoxContainer

onready var PART_BUTTON : PackedScene = preload("res://src/UserInterface/PartButton.tscn")
const PARTS_DIR : String = "res://src/Parts/"
var selected_part_path : String = ""
onready var Sandbox : Node2D = find_parent("Sandbox")

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

	for path in files:
		add_button(path)
		pass

func _process(delta):
	# Part placement if part selected.

	if selected_part_path != "" && Input.is_action_just_pressed("editor_place"):
		print_debug("part path: " + selected_part_path)
		var new_part = load(PARTS_DIR + selected_part_path).instance()
		Sandbox.add_child(new_part)
		new_part.set_position(get_viewport().get_mouse_position())
		selected_part_path = ""
	
func add_button(path):
	var new_button = PART_BUTTON.instance()
	new_button.path = path
	new_button.text = path.trim_prefix(PARTS_DIR).trim_suffix(".tscn")
	self.add_child(new_button)
	pass

