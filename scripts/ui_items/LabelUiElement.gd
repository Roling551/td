extends UiElement
class_name LabelUiElement

var text
var container
var control
var label

func _init(_text):
	text = _text

func activate_ui(container_):
	container = container_
	control = ControlUtil.get_expanded_control()
	container.add_child(control)
	label = Label.new()
	label.text = text
	control.add_child(label)
	
func deactivate_ui():
	control.queue_free()
