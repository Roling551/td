extends Node
class_name ResourcesComponent

var resources_container
var resource_action

func has_ui():
	return false

func _init(_resources_container, _resource_action):
	resources_container = _resources_container
	resource_action = _resource_action

func action():
	resource_action.call()
