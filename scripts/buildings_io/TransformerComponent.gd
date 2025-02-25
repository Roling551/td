extends BuildingComponent
class_name TransformerComponent

var building
var input: InputTile
var output: OutputTile

var label

func _init(_building, _input, _output):
	building = _building
	input = _input
	output = _output
	building.functionalities["input_action"] = func(): 
		output.forward(input.payload + "_a")

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
	label.text = str("test")
	
func _enter_tree():
	MainScript.update_ui.add_updateable(self)

func _exit_tree():
	MainScript.update_ui.remove_updateable(self)
	
