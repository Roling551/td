extends Node
class_name UpdateList

var main
var updateable_ui = {}

func _init(_main):
	main = _main

func add_updateable_child(parent, child):
	if("update_ui" in child):
		updateable_ui[child] = null
	parent.add_child(child)
	
func queue_updateable_child(child):
