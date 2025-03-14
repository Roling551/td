extends Control
class_name UpdateableWrap

var updateable

func _init(_updateable) -> void:
	ControlUtil.set_anchor_full_rect(self)
	ControlUtil.expand_control(self)
	updateable = _updateable

func _enter_tree():
	MainScript.update_ui.add_updateable(updateable)

func _exit_tree():
	MainScript.update_ui.remove_updateable(updateable)
