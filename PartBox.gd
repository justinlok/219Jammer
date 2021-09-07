extends VBoxContainer

onready var PART_BUTTON : PackedScene = preload("res://src/UserInterface/PartButton.tscn")
onready var sandbox : Node2D = find_parent("Sandbox")
const PARTS_DIR : String = "res://src/Parts/"
var new_part : Node2D = null
var new_part_collision_shapes = []
var is_modifier : bool = false

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

func _process(_delta):
	if  new_part != null:
		# Part ghosting when selected.
		if is_instance_valid(new_part):
			new_part.set_position(get_viewport().get_mouse_position())
		else:
			new_part = null

func _input(event):
	# Check key modifier.
	if event.is_action_pressed("editor_modifier"):
		is_modifier = true
	if event.is_action_released("editor_modifier"):
		is_modifier = false

	# Part placement & handeling.
	if new_part == null:
		return
	if event.is_action_pressed("editor_rotate_cw"):
		if is_modifier:
			new_part.rotate(45 * PI /180)
		else:
			new_part.rotate(15 * PI / 180)
	elif event.is_action_pressed("editor_rotate_ccw"):
		if is_modifier:
			new_part.rotate(-45 * PI /180)
		else:
			new_part.rotate(-15 * PI / 180)
	elif event.is_action_pressed("editor_scale_x+"):
		if is_modifier:
			new_part.scale = Vector2(new_part.scale.x + 0.5, new_part.scale.y)
		else:
			new_part.scale = Vector2(new_part.scale.x + 0.1, new_part.scale.y)
	elif event.is_action_pressed("editor_scale_x-"):
		if is_modifier:
			new_part.scale = Vector2(new_part.scale.x - 0.5, new_part.scale.y)
		else:
			new_part.scale = Vector2(new_part.scale.x - 0.1, new_part.scale.y)
	elif event.is_action_pressed("editor_scale_y+"):
		if is_modifier:
			new_part.scale = Vector2(new_part.scale.x, new_part.scale.y + 0.5)
		else:
			new_part.scale = Vector2(new_part.scale.x, new_part.scale.y + 0.1)
	elif event.is_action_pressed("editor_scale_y-"):
		if is_modifier:
			new_part.scale = Vector2(new_part.scale.x, new_part.scale.y - 0.5)
		else:
			new_part.scale = Vector2(new_part.scale.x, new_part.scale.y - 0.1)
	elif event.is_action_pressed("editor_place"):
		if is_modifier:
			print_debug("Pressed")
			var path : String = new_part.filename
			print_debug ("path " + path)
			_place_part()
			set_selected_part(path)
		else:
			_place_part()

func _place_part() -> void:
	new_part.set_process(true)
	for collision_shape_2d in new_part_collision_shapes:
		collision_shape_2d.disabled = false
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
	new_part.modulate = Color(
		new_part.modulate.r, new_part.modulate.g, new_part.modulate.b, 0.5)
	sandbox.add_child(new_part)
	new_part.set_process(false)
	new_part_collision_shapes = _GetAllEnabledCollisionShape2Ds(new_part)
	for collision_shape_2d in new_part_collision_shapes:
		collision_shape_2d.disabled = true
	

func _GetAllEnabledCollisionShape2Ds(node):
	var collision_shape_2ds = []
	if node is CollisionShape2D || node is CollisionPolygon2D:
		if !node.disabled:
			collision_shape_2ds.append(node)
	var children = node.get_children()
	for child in children:
		collision_shape_2ds.append_array(_GetAllEnabledCollisionShape2Ds(child))
	return collision_shape_2ds
		
		
