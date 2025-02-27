extends BuildingComponent
class_name ProviderComponent

var building
var output: OutputTile
var label

func provide_payload():
	return "test"

func _init(_building, _output):
	building = _building
	output = _output
	building.functionalities["turn_action"] = func(): 
		output.forward(true, provide_payload())
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

func _enter_tree():
	MainScript.update_ui.add_updateable(self)

func _exit_tree():
	MainScript.update_ui.remove_updateable(self)
