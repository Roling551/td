extends Node
class_name PopulationSystem

@export var resource_container: Node

var citizen_groups = {}

var resource_items = {}

func _init():
	citizen_groups["settlers"] = Group.new(20)

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	resource_items[name] =  ControlUtil.create_resource_item_and_add(ui, "population_sprite", func():
		return str(citizen_groups["settlers"].population, " (", citizen_groups["settlers"].avaliable_population, ")")
	)
	return updateable_wrap


func update_ui():
	for item in resource_items:
		resource_items[item].update()

func change_population(population_change):
	citizen_groups["settlers"].change_population(population_change)
	MainScript.update_ui.mark_for_update()
	
