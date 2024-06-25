extends VFlowContainer

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")
@onready var population_sprite = preload("res://sprites/resource_sprites/rat.png")
@onready var working_sprite = preload("res://sprites/resource_sprites/working.png")
@onready var unemployed_sprite = preload("res://sprites/resource_sprites/unemployed.png")
@onready var bed_sprite = preload("res://sprites/resource_sprites/bed.png")
var population_item
var working_item
var rest_item
var unemployed_item

var population = []
var working_population = []
var resting_population = []
var unemployed_population = []

func _ready():
	population_item = resource_item_prototype.instantiate()
	add_child(population_item)
	population_item.set_icon(population_sprite)
	working_item = resource_item_prototype.instantiate()
	add_child(working_item)
	working_item.set_icon(working_sprite)
	rest_item = resource_item_prototype.instantiate()
	add_child(rest_item)
	rest_item.set_icon(bed_sprite)
	unemployed_item = resource_item_prototype.instantiate()
	add_child(unemployed_item)
	unemployed_item.set_icon(unemployed_sprite)	
	update()

func update():
	population_item.set_text(str(population.size()))
	working_item.set_text(str(working_population.size() - unemployed_population.size()))
	rest_item.set_text(str(resting_population.size()))
	unemployed_item.set_text(str(unemployed_population.size()))

func change_population(population_change):
	if population_change>0:
		for i in population_change:
			population.append(Citizen.new())
			
func assign_population(buildings, city):
	working_population = []
	resting_population = []
	unemployed_population = []
	for citizen in population:
		if citizen.rest > 0.5:
			working_population.append(citizen)
		else:
			resting_population.append(citizen)
	
	var needed_workers_num = 0
	city.reset_population()
	for building in buildings:
		if building.building_components.has("population"):
			building.building_components["population"].reset_population()
			needed_workers_num += building.building_components["population"].max_population
	if working_population.size() >= needed_workers_num:
		unemployed_population = working_population.slice(needed_workers_num)
		var assigned_population_num = 0
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				var population_to_assign = working_population.slice(assigned_population_num, assigned_population_num+population_component.max_population)
				population_component.assign_population(population_to_assign)
				assigned_population_num += population_component.max_population
	else:
		var assigned_population_num = 0
		for building in buildings:
			if building.building_components.has("population"):
				var population_component = building.building_components["population"]
				var population_to_assign_num = floor(working_population.size() * population_component.max_population / needed_workers_num)
				population_component.assign_population(working_population.slice(assigned_population_num, assigned_population_num+population_to_assign_num))
				assigned_population_num += population_to_assign_num
		for building in buildings:
			if building.building_components.has("population"):
				if assigned_population_num == working_population.size():
					break
				building.building_components["population"].assign_population(working_population.slice(assigned_population_num, assigned_population_num+1))
				assigned_population_num += 1
	city.assign_population(resting_population)
	city.assign_population(unemployed_population)
		
