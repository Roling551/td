extends Node
class_name ConsumerComponent

var building
var input: InputTile

func _init(_building, _input):
	building = _building
	input = _input
	building.functionalities["input_action"] = func(): 
		print(input.payload)
