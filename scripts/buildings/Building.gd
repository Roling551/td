extends Node2D
class_name Building

var location
var building_components
var functionalities = {}
var item_list
var tiles

func _init(building_components_):
	building_components = building_components_

func set_location_and_tiles(_location, _tiles):
	tiles = _tiles
	location = _location

func action():
	if(functionalities.has("turn_action")):
		functionalities["turn_action"].call()

func get_ui():
	item_list = HBoxContainer.new()
	Util.setAnchorFullRect(item_list)
	
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			component.activate_ui(item_list)
	
	update_ui()
	return item_list
	
func update_ui():
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			component.update_ui()
