extends Node
class_name TileMapActions

var camera = MainScript.camera

var click_function
var hover_tile_function
var hover_tile_coord
var hover_tile_map

func _init(_camera):
	camera = _camera

func handle_click(tile_map, mouse_input_event):
	if click_function:
		if mouse_input_event.pressed:
			var tile_coord = get_tile_coord(tile_map)
			click_function.call(tile_map, tile_coord)

func handle_mouse_moved(tile_map, mouse_input_event):
	var tile_coord = get_tile_coord(tile_map)
	if hover_tile_coord != tile_coord || hover_tile_map != tile_map:
		hover_tile_coord = tile_coord
		hover_tile_map = tile_map
		if hover_tile_function:
			hover_tile_function.call(tile_map, hover_tile_coord)
	
func get_tile_coord(tile_map):
	return ControlUtil.mouse_to_tile(tile_map, camera)

func set_click_function(function_):
	click_function = function_

func set_hover_tile_function(function_):
	hover_tile_function = function_
