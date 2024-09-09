extends Node2D
class_name Building

var building_components
var active_panel
var item_list

func _init(building_components_):
	building_components = building_components_

func action():
	for name in building_components:
		building_components[name].action()

func activate_ui(active_panel_):
	active_panel = active_panel_
	item_list = HBoxContainer.new()
	Util.setAnchorFullRect(item_list)
	
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			component.activate_ui(item_list)
	
	active_panel.add_child(item_list)
	update_ui()
	
func deactivate_ui():
	item_list.queue_free()
	item_list = null
	active_panel = null
	
func update_ui():
	for name in building_components:
		var component = building_components[name]
		if component.has_ui():
			component.update_ui()
