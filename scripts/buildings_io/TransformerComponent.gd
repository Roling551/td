extends BuildingComponent
class_name TransformerComponent

var building
var inputs
var outputs
var transform_function

var label

func _init(_building, _inputs, _outputs, _transform_function):
	building = _building
	inputs = _inputs
	outputs = _outputs
	transform_function = _transform_function
	building.functionalities["input_action"] = func(actual):
		transform_function.call(inputs, outputs)
		_forward(actual)

func _forward(actual):
	for n in outputs.size():
		outputs[n]["tile"].forward(actual, outputs[n]["payload"])

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
	var text = ""
	text += Util.val_or_def(inputs.map(func(x): 
		return x["tile"].payload
	).reduce(func(accum, x):
		return Util.val_or_def(accum, "<null>") + " + " + Util.val_or_def(x, "<null>")
	), "<null>")
	text += "   ->   "
	text += Util.val_or_def(outputs.map(func(x): 
		return x["tile"].payload
	).reduce(func(accum, x):
		return Util.val_or_def(accum, "<null>") + " + " + Util.val_or_def(x, "<null>")
	), "<null>")
	label.text = text

func _enter_tree():
	MainScript.update_ui.add_updateable(self)

func _exit_tree():
	MainScript.update_ui.remove_updateable(self)
	
