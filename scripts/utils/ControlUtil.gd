extends Node
class_name ControlUtil

const resource_item_prototype = preload("res://scenes/resource_item.tscn")

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
	
