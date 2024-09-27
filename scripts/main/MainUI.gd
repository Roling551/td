extends Node
class_name MainUI

var main
var active_ui

func _init(main_script_):
	main = main_script_
	set_action(default_action)

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main.tile_map_actions.handle_click(main.tile_map, event)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			set_action(default_action)
		
var default_action = func(tile_map, tile_position):
	var building = main.buildings_list.get_building_at(tile_map, tile_position)
	change_ui(building)

func set_action(action, ui = null):
	main.tile_map_actions.set_click_function(action)
	if active_ui:
		active_ui.deactivate_ui()
	change_ui(ui)

func _get_2_point_action_function(first_click_condition, get_first_value, action):
	return func(tile_map_1, tile_position_1):
		if first_click_condition.call(tile_map_1, tile_position_1):
			var first_value = get_first_value.call(tile_map_1, tile_position_1)
			main.tile_map_actions.set_click_function(
				func(tile_map_2, tile_position_2):
					action.call(first_value, tile_map_1, tile_position_1, tile_map_2, tile_position_2)
					main.tile_map_actions.set_click_function(_get_2_point_action_function(first_click_condition, get_first_value, action))
			)


func set_2_point_action(first_click_condition, get_first_value, action, ui = null):
	change_ui(ui)
	main.tile_map_actions.set_click_function(_get_2_point_action_function(first_click_condition, get_first_value, action))

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
