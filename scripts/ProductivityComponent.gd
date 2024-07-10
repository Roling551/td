extends Node
class_name ProductivityComponent

var population_component

var productivity = 0

func _init(_building):
	population_component = _building.building_components["population"]

func has_ui():
	return false

func action():
	productivity = calculate_productivity()

func calculate_productivity():
	return float(population_component.assigned_population.size()) / population_component.max_population
