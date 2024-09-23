extends BuildingComponent
class_name TransformerComponent

var building
var input: InputTile
var output: OutputTile

func _init(_building, _input, _output):
	building = _building
	input = _input
	output = _output
	building.functionalities["input_action"] = func(): 
		output.forward(input.payload + "_a")

func provide():
	return 1

func consume():
	pass
