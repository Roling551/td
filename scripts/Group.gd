extends Node
class_name Group

var population
var avaliable_population

var needs = {}
var needs_state = {}

func _init(_population):
	population = _population
	avaliable_population = population
	_add_need("food", 0.1)
	
func _add_need(name, amount):
	needs[name] = amount
	needs_state[name] = 0.0

func change_population(population_change):
	population = max(population + population_change, 0)
	avaliable_population = population
