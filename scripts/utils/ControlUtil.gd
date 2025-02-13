extends Node
class_name ControlUtil

const resource_item_prototype = preload("res://scenes/resource_item.tscn")

static func mouse_to_tile(node, camera):
	var physical_size_y = tan(deg_to_rad(camera.fov/2))*(camera.position.z-node.position.z)
	var scree_size = node.get_viewport().get_visible_rect().size
	var part_of_screen = node.get_viewport().get_mouse_position()/scree_size
	var part_of_rect = Vector2((part_of_screen.x-0.5)*2*scree_size.x/scree_size.y, (part_of_screen.y-0.5)*-2)
	var physical_coordinates = part_of_rect * physical_size_y
	return world_to_tile(physical_coordinates)

static func world_to_tile(v):
	return Vector2i(roundf(v.x), roundf(v.y))

static func tile_to_world(v: Vector2i):
	return Vector3(v.x, v.y, 0)

static func create_resource_item(obj, sprite_name, update_method):
	var resource_item = resource_item_prototype.instantiate()
	obj.add_child(resource_item)
	resource_item._set_icon(Sprites.sprites[sprite_name])
	resource_item._set_update_method(update_method)
	return resource_item

static func get_expanded_control():
	var control = Control.new()
	expand_control(control)
	return control
	
static func expand_control(control): 
	control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	control.size_flags_vertical = Control.SIZE_EXPAND_FILL

static func set_anchor_full_rect(control: Control):
	control.anchor_left = 0
	control.anchor_right = 1
	control.anchor_top = 0
	control.anchor_bottom = 1

static func get_go_and_back(name, go_back_to, panel):
	var go_back_panel = GoBackPanel.new(panel, go_back_to)
	var go_to_button = GoToButton.new(name,  go_back_panel)
	return go_to_button
	
