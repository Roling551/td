extends Node
class_name BuildingComponent

var building: Building

func _init(_building: Building):
	building = _building

func has_ui():
	return false

func before_delete():
	pass
