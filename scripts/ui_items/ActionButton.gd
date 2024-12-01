extends Button
class_name ActionButton

func _init(_text, _action):
	text = _text
	pressed.connect(_action)
