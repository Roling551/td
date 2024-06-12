extends Node2D
class_name Building

var building_components

func _init(building_components_):
	building_components = building_components_

func action():
	for name in building_components:
		building_components[name].action()
