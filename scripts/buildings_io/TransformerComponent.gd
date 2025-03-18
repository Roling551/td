extends PipeComponent
class_name TransformerComponent

var inputs
var outputs
var transform_function
var turned_on = false

var label

func _init(building, _inputs, _outputs, _transform_function):
	super(building)
	inputs = _inputs
	outputs = _outputs
	transform_function = _transform_function
	building.functionalities["input_action"] = func(actual):
		turned_on = transform_function.call(inputs, outputs)
		building.update_components(self)
		_forward(actual)

func is_turned_on():
	return turned_on

func _forward(actual):
	for n in outputs.size():
		outputs[n]["tile"].forward(actual, outputs[n]["tile"].payload)

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
		return Util.func_if_not_null(x["tile"].payload, func(x): return x.get_text())
	).reduce(func(accum, x):
		return Util.val_or_def(accum, "<null>") + " + " + Util.val_or_def(x, "<null>")
	), "<null>")
	text += "   ->   "
	text += Util.val_or_def(outputs.map(func(x):
		return Util.func_if_not_null(x["tile"].payload, func(x): return x.get_text())
	).reduce(func(accum, x):
		return Util.val_or_def(accum, "<null>") + " + " + Util.val_or_def(x, "<null>")
	), "<null>")
	label.text = text
