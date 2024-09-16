extends Node
class_name InputComponent

var building
var inputs
var not_activated = {}
var activated = {}

func _init(_building, _inputs):
	building = _building
	inputs = _inputs
	new_turn()

func new_turn():
	for input in inputs:
		not_activated[input] = null
	activated = {}
	
func activate(input):
	not_activated.erase(input)
	activated[input]=null
	if not_activated.is_empty():
		building.functionalities["input_action"].call()
