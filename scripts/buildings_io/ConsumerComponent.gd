extends PipeComponent
class_name ConsumerComponent

var input: InputTile
var payload
var label

func _init(building, _input):
	super(building)
	input = _input
	building.functionalities["input_action"] = func(actual):
		payload = input.payload
		if actual:
			print("consumer:")
			print(input.payload.get_text())

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
		label.text = payload.get_text()
	else:
		label.text = ""
