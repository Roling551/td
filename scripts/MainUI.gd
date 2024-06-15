extends Node
class_name MainUI

var main_script
var active_ui

func _init(main_script_):
	main_script = main_script_
	main_script.tile_map_actions.set_click_function(default_action)

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		main_script.tile_map_actions.handle_click(main_script.tile_map, event)
		
var default_action = func(tile_map, tile_position):
	var building = main_script.buildings_list.get_building_at(tile_map, tile_position)
	change_ui(building)
		
func change_ui(new_ui):
	if active_ui==new_ui:
		return
	if active_ui:
		active_ui.deactivate_ui()
	if new_ui:
		new_ui.activate_ui(main_script.active_panel)
	active_ui = new_ui

func update_ui():
	if active_ui:
		active_ui.update_ui()
