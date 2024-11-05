extends Node
class_name UpdateUI

var update_list = []
var marked_for_update = false

func mark_for_update():
	marked_for_update = true
	
func add_updateable(updateable):
	update_list.push_back(updateable)
	mark_for_update()

func remove_updateable(updateable):
	update_list.erase(updateable)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !marked_for_update:
		return
	for item in update_list:
		item.update_ui()
	marked_for_update = false
