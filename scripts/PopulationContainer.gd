extends VFlowContainer

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")
var population_sprite = preload("res://sprites/resource_sprites/rat.png")
var population_item

var population = 0

func _ready():
	population_item = resource_item_prototype.instantiate()
	add_child(population_item)
	population_item.set_icon(population_sprite)

func update():
	population_item.set_text(str(snapped(population,0.1)))
	
func change_population(population_change):
	population = max(0,population_change+population)

func assign_population(buildings):
	var needed_workers = 0
	var buildings_needing_workers = 0
	for building in buildings:
		if building.building_components.has("population"):
			buildings_needing_workers += 1
			needed_workers += building.building_components["population"].max_population
	if population >= needed_workers:
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				population_component.assigned_population = population_component.max_population
	else:
		var assigned_population = 0
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				var population_to_assign = floor(population * population_component.max_population / needed_workers)
				population_component.assigned_population = population_to_assign
				assigned_population += population_to_assign
		var n = population - assigned_population
		for building in buildings:
			if building.building_components.has("population"):
				if n == 0:
					break
				building.building_components["population"].assigned_population += 1
				n -= 1
