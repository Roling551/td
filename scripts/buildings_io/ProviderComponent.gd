extends BuildingComponent
class_name ProviderComponent

var building
var output: OutputTile
var label
var provided_payload = "test"

func provide_payload():
	return provided_payload

func _init(_building, _output):
	building = _building
	output = _output
	building.functionalities["end_turn_action"] = func():
		provided_payload += ">"
	building.functionalities["init_pipes_action"] = func(actual): 
		output.forward(actual, provide_payload())
	output.forward(false, provide_payload())

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
		label.text = provide_payload()
