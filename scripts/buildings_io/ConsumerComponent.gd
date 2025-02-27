extends BuildingComponent
class_name ConsumerComponent

var building
var input: InputTile
var payload
var label

func _init(_building, _input):
	building = _building
	input = _input
	building.functionalities["input_action"] = func(actual):
		payload = input.payload
		if actual:
			print(input.payload)

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
	if payload != null:
		label.text = payload
	else:
		label.text = ""

func _enter_tree():
	MainScript.update_ui.add_updateable(self)

func _exit_tree():
	MainScript.update_ui.remove_updateable(self)
