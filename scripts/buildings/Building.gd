extends Node3D
class_name Building

var location
var building_components
var functionalities = {}
var item_list
var tiles
var update_relations = OneToMany.new()

func _init(building_components_):
	building_components = building_components_

func set_location_and_tiles(_location, _tiles):
	tiles = _tiles
	location = _location

func end_turn_action():
	if functionalities.has("end_turn_action"):
		functionalities["end_turn_action"].call()

func init_pipe_action(actual):
	if functionalities.has("init_pipes_action"):
		functionalities["init_pipes_action"].call(actual)

func before_pipe_action():
	if building_components.has("input"):
		building_components["input"].before_pipe_action()

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	item_list = HBoxContainer.new()
	updateable_wrap.add_child(item_list)
	ControlUtil.set_anchor_full_rect(item_list)
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			var c = component.activate_ui()
			item_list.add_child(c)
	update_ui()
	return updateable_wrap

func update_ui():
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			component.update_ui()

func update_components(updating_component):
	for component in update_relations.get_array(updating_component):
		component.update()
