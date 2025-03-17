extends BuildingComponent
class_name InputComponent

var inputs
var valid = {}

func _init(building, _inputs):
	super(building)
	inputs = _inputs
	before_pipe_action()

func before_pipe_action():
	valid = {}
	for input in inputs:
		if !input.has_connection():
			valid[input] = null
	
func activate_input(actual, input):
	valid[input]=null
	if valid.size() == inputs.size():
		building.functionalities["input_action"].call(actual)
