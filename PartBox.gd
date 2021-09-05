extends VBoxContainer

onready var PART_BUTTON : PackedScene = preload("res://src/UserInterface/PartButton.tscn")
const PARTS_DIR : String = "res://src/Parts"
var selected_part : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
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
		
func add_button(path):
	var new_button = PART_BUTTON.instance()
	new_button.path = path
	new_button.text = path.trim_prefix(PARTS_DIR).trim_suffix(".tscn")
	self.add_child(new_button)
	pass
