extends Node
class_name PreBuildInfo

var create_building_and_tiles_func
var pattern
var create_graphic_node_tiles_func

func _init(_create_building_and_tiles_func,  _pattern,  _create_graphic_node_tiles_func):
	create_building_and_tiles_func = _create_building_and_tiles_func
	pattern = _pattern
	create_graphic_node_tiles_func = _create_graphic_node_tiles_func
	
func create_building_and_tiles():
	return create_building_and_tiles_func.call()

func create_graphic_node_tiles():
	return create_graphic_node_tiles_func.call()
