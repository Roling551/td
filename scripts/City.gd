extends Node
class_name City

var population_container

var label
var assigned_population = []

func _init(_population_container):
	population_container = _population_container
	
func reset_population():
	assigned_population = []
	
func assign_population(population):
	assigned_population.append_array(population)

func action():
	for citizen in assigned_population:
		citizen.rest(1.0)
