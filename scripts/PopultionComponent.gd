extends Node
class_name PopulationComponent

var population_container

var container
var label
var max_population = 10
var assigned_population = 0

func _init(_population_container):
	population_container = _population_container

func has_ui():
	return true

func action():
	population_container.change_rest(-0.1, assigned_population)

func activate_ui(container_):
	container = container_
	var c = Control.new()
	c.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	c.size_flags_vertical = Control.SIZE_EXPAND_FILL
	container.add_child(c)
	label = Label.new()
	c.add_child(label)

func update_ui():
	label.text = str(assigned_population,"/",max_population)

func get_wanted_population():
	return max_population
	
func assign_population(population):
	assigned_population = population
