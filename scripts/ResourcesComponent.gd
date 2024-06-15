extends Node
class_name ResourcesComponent

var resources_container

func has_ui():
	return false

func _init(_resources_container):
	resources_container = _resources_container

func action():
	resources_container.change_resource("wood", 0.001)
