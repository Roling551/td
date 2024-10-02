extends Node
class_name MainUI

var main
var active_ui
var deselect_action_function

func _init(main_script_):
	main = main_script_
	set_action(default_action)
	
func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main.tile_map_actions.handle_click(main.tile_map, event)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			deselect_action()
	elif event is InputEventMouseMotion:
		main.tile_map_actions.handle_mouse_moved(main.tile_map, event)

func set_deselect_action_function(_deselect_action_function):
	deselect_action_function = _deselect_action_function

func deselect_action():
	change_ui(null)
	if deselect_action_function:
		deselect_action_function.call()
		deselect_action_function = null
	main.tile_map_actions.set_hover_tile_function(null)
	main.tile_map_actions.set_click_function(default_action)

func set_action(action, ui = null):
	deselect_action()
	main.tile_map_actions.set_click_function(action)
	if ui:
		change_ui(ui)
		
var default_action = func(tile_map, tile_coord):
	var building = main.buildings_list.get_building_at(tile_map, tile_coord)
	change_ui(building)

func change_ui(new_ui):
	if active_ui==new_ui:
		return
	if active_ui:
		active_ui.deactivate_ui()
	if new_ui:
		new_ui.activate_ui(main.active_panel)
	active_ui = new_ui

func update_ui():
	if active_ui:
		active_ui.update_ui()

func set_hover_tile_function(hover_action):
	main.tile_map_actions.set_hover_tile_function(hover_action)

func _get_2_point_action_function(first_click_condition, get_first_value, action):
	return func(tile_map_1, tile_coord_1):
		if first_click_condition.call(tile_map_1, tile_coord_1):
			var first_value = get_first_value.call(tile_map_1, tile_coord_1)
			main.tile_map_actions.set_click_function(
				func(tile_map_2, tile_coord_2):
					action.call(first_value, tile_map_1, tile_coord_1, tile_map_2, tile_coord_2)
					main.tile_map_actions.set_click_function(_get_2_point_action_function(first_click_condition, get_first_value, action))
			)
func set_2_point_action(first_click_condition, get_first_value, action, ui = null):
	deselect_action()
	main.tile_map_actions.set_click_function(_get_2_point_action_function(first_click_condition, get_first_value, action))
	change_ui(ui)
