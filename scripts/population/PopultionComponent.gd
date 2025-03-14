extends Node
class_name PopulationComponent

var container
var label
var max_population = 10
var assigned_group_parts = {}
var assigned_population_num = 0

func _init():
	pass

func has_ui():
	return true

func action():
	pass

func activate_ui():
	var c = ControlUtil.get_expanded_control()
	label = Label.new()
	c.add_child(label)
	return c

func update_ui():
	label.text = str(assigned_population_num,"/",max_population)

func set_assigned_population_num():
	var population_num = 0
	for group in assigned_group_parts:
		population_num += assigned_group_parts[group].population
	assigned_population_num = population_num

func get_wanted_population():
	return max_population

func reset_population():
	assigned_group_parts = {}
	set_assigned_population_num()

func assign_population(group_part):
	var group = group_part
	if assigned_group_parts.has(group):
		assigned_group_parts[group].add(group_part)
	else:
		assigned_group_parts[group] = group_part
	set_assigned_population_num()
