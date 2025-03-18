extends Node
class_name TurnSystem

var date_item
var new_turn_button
var new_turn_function
var turn = 0

var errors = {}

func _init(_new_turn_function):
	new_turn_function = _new_turn_function

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	date_item = ControlUtil.create_resource_item_and_add(ui, "date_sprite", func():return str(turn))
	new_turn_button  = ActionButton.new("Next turn", new_turn)
	ui.add_child(new_turn_button)
	return updateable_wrap

func update_ui():
	date_item.update()
	new_turn_button.disabled = !errors.is_empty()

func add_error(error, message):
	errors[error] = message
	MainScript.update_ui.mark_for_update()

func remove_error(error):
	errors.erase(error)
	MainScript.update_ui.mark_for_update()

func new_turn():
	#new_turn_button.disabled = true
	turn += 1
	new_turn_function.call()
	MainScript.update_ui.mark_for_update()
