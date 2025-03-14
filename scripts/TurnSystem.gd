extends Node
class_name TurnSystem

var date_item

var turn = 0

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	date_item = ControlUtil.create_resource_item_and_add(ui, "date_sprite", func():return str(turn))
	return updateable_wrap

func update_ui():
	date_item.update()

func proceed_turn():
	turn += 1
	MainScript.update_ui.mark_for_update()
