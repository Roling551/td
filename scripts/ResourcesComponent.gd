extends Node
class_name ResourcesComponent

var productivity_component
var resources_container
var resource_action

func has_ui():
	return false

func _init(_building, _resources_container, _resource_action):
	productivity_component = _building.building_components["productivity"]
	resources_container = _resources_container
	resource_action = _resource_action

func action():
	resource_action.call(productivity_component.productivity)
