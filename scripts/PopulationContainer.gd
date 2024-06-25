extends VFlowContainer

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")
@onready var population_sprite = preload("res://sprites/resource_sprites/rat.png")
@onready var bed_sprite = preload("res://sprites/resource_sprites/bed.png")
var population_item
var rest_item

var population = 0
var rest = 1

const needs_display_multiplication = 100

func _ready():
	population_item = resource_item_prototype.instantiate()
	add_child(population_item)
	population_item.set_icon(population_sprite)
	rest_item = resource_item_prototype.instantiate()
	add_child(rest_item)
	rest_item.set_icon(bed_sprite)	
	update()

func update():
	rest = clamp(rest, 0, 1)
	population_item.set_text(str(population))
	rest_item.set_text(str(snapped(rest * needs_display_multiplication, 0.1)) + "/100")
	
func change_population(population_change):
	population = max(0,population_change+population)

func change_rest(change, affected_population):
	if population > 0:
		rest += change * (float(affected_population) / float(population)) / float(GlobalConst.frame_per_hour)

func assign_population(buildings, city):
	var resting_population = ceil(population * (1-rest))
	var working_population = population - resting_population
	
	var needed_workers = 0
	var buildings_needing_workers = 0
	for building in buildings:
		if building.building_components.has("population"):
			buildings_needing_workers += 1
			needed_workers += building.building_components["population"].max_population
	var unemployed_population = 0
	if working_population >= needed_workers:
		unemployed_population = working_population - needed_workers
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				population_component.assigned_population = population_component.max_population
	else:
		var assigned_population = 0
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				var population_to_assign = floor(working_population * population_component.max_population / needed_workers)
				population_component.assigned_population = population_to_assign
				assigned_population += population_to_assign
		var n = working_population - assigned_population
		for building in buildings:
			if building.building_components.has("population"):
				if n == 0:
					break
				building.building_components["population"].assigned_population += 1
				n -= 1
	city.assign_population(resting_population + unemployed_population)
