extends PipeComponent
class_name ProviderComponent

var output: OutputTile
var label
var provided_payload

func provide_payload():
	return provided_payload

func _init(building, _output, _provided_payload):
	super(building)
	provided_payload = _provided_payload
	output = _output
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
	label.text = provide_payload().get_text()
