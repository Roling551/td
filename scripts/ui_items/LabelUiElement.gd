extends Control
class_name LabelUiElement

var text
var label

func _init(_text):
	text = _text
	ControlUtil.expand_control(self)
	label = Label.new()
	label.text = text
	add_child(label)
