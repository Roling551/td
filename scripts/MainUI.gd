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

func set_action(action):
	main.tile_map_actions.set_click_function(action)
	if active_ui:
		active_ui.deactivate_ui()
		active_ui = null

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
