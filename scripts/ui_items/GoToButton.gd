extends Button
class_name GoToButton

var panel_to_go
var panel_from
var container

func _init(_text, _panel_to_go):
	text = _text
	panel_to_go = _panel_to_go

func _enter_tree():
	panel_from = get_parent()
	container = panel_from.get_parent()
	pressed.connect(on_click)

func on_click():
	container.remove_child(panel_from)
	container.add_child(panel_to_go)
