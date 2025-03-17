extends Node
class_name PopulationSystem

@export var resource_container: Node

var population_number = 10
var population_needed = 0
var resource_item

func _init():
	pass

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	resource_item =  ControlUtil.create_resource_item_and_add(ui, "population_sprite", func():
		return str(population_needed) + " / " + str(population_number)
	)
	return updateable_wrap

func update_ui():
	resource_item.update()

func change_populaion_needed(needed_change):
	population_needed += needed_change
	MainScript.update_ui.mark_for_update()
	
func change_population(population_change):
	population_number += population_change
	MainScript.update_ui.mark_for_update()
	
