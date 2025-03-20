extends Node
class_name PopulationSystem

@export var resource_container: Node

var population_number = 10
var population_needed = SumationDictionary.new()
var resource_item

func _init():
	pass

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	resource_item =  ControlUtil.create_resource_item_and_add(ui, "population_sprite", func():
		return str(population_needed.get_sum()) + " / " + str(population_number)
	)
	return updateable_wrap

func update_ui():
	resource_item.update()

func check_if_sufficient():
	if population_needed.get_sum() > population_number:
		MainScript.turn_system.add_error(self, "Not enough workers")
	else:
		MainScript.turn_system.remove_error(self)

func change_populaion_needed(needing_object, amount):
	population_needed.update(needing_object, amount)
	check_if_sufficient()
	MainScript.update_ui.mark_for_update()
	
func change_population(population_change):
	population_number += population_change
	check_if_sufficient()
	MainScript.update_ui.mark_for_update()
	
