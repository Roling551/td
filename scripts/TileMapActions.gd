extends Node
class_name TileMapActions

@onready var camera = get_node("../Camera2D")

var click_function

func _init(_camera):
	camera = _camera

func handle_click(tile_map, mouse_input_event):
	if click_function:
		if mouse_input_event.pressed:
			var tile_pos = get_tile_position(tile_map)
			click_function.call(tile_map, tile_pos)

func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position
	
func get_tile_position(tile_map):
	return tile_map.local_to_map(tile_map.get_viewport().get_mouse_position()/camera.zoom.x - tile_map.get_viewport().get_visible_rect().size/(2*camera.zoom.x) + camera.position - tile_map.global_position)

func set_click_function(function_):
	click_function = function_
