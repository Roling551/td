extends BuildingComponent
class_name TransformerComponent

var building
var input: InputTile
var output: OutputTile
var output_payload

var label

func _init(_building, _input, _output):
	building = _building
	input = _input
	output = _output
	building.functionalities["input_action"] = func(actual):
		if input.payload != null:
			output_payload = input.payload + "_a"
		else:
			output_payload = null
		output.forward(actual, output_payload)


func has_ui():
	return true

func action():
	pass

func activate_ui():
	var c = ControlUtil.get_expanded_control()
	label = Label.new()
	c.add_child(label)
	return c

func update_ui():
	if output_payload != null:
		label.text = output_payload
	else:
		label.text = ""

func _enter_tree():
	MainScript.update_ui.add_updateable(self)

func _exit_tree():
	MainScript.update_ui.remove_updateable(self)
	
