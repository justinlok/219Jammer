extends VBoxContainer

onready var PART_BUTTON : PackedScene = preload("res://src/UserInterface/PartButton.tscn")
onready var sandbox : Node2D = find_parent("Sandbox")
const PARTS_DIR : String = "res://assets/sprites/backgrounds/"
onready var background : Sprite = get_parent().get_parent().get_parent().get_node("Background")

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
		elif file.ends_with(".jpeg") or file.ends_with(".png"):
			files.append(file)
			
	dir.list_dir_end()
	print_debug("Parts list size: "  + String(files.size()))

	for file in files:
		_add_button(file)
		pass

func _add_button(file : String) -> void:
	var new_button = PART_BUTTON.instance()
	new_button.path = PARTS_DIR + file
	new_button.text = file.trim_suffix(".jpeg")
	new_button.text = file.trim_suffix(".png")
	self.add_child(new_button)
	pass

func set_selected_part(path) -> void:
	background.set_texture(load(path))
