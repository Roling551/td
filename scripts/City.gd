extends Node
class_name City

var population_container

var label
var assigned_population = 0

func _init(_population_container):
	population_container = _population_container
	
func assign_population(population):
	assigned_population = population

func action():
	population_container.change_rest(0.1, assigned_population)
