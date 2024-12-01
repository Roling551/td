extends VBoxContainer
class_name GoBackPanel

var panel
var button
var go_back_to
var container

func _init(_panel, _go_back_to) -> void:
	panel = _panel
	go_back_to = _go_back_to
	ControlUtil.set_anchor_full_rect(self)
	button = Button.new()
	button.text = "<"
	add_child(button)
	add_child(panel)

func _enter_tree():
	container = get_parent()
	button.pressed.connect(go_back)

func go_back():
	container.remove_child(self)
	container.add_child(go_back_to)
