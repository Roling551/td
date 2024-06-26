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
	working_item.set_text(str(working_population.size()))
	rest_item.set_text(str(resting_population.size()))
	unemployed_item.set_text(str(unemployed_population.size()))

func change_population(population_change):
	if population_change>0:
		for i in population_change:
			population.append(Citizen.new())
						
func working_pay(civilian):
	civilian.feed(0.1)
	
func unemployed_pay(civilian):
	civilian.feed(0.02)

func citizens_action():
	for citizen in population:
		citizen.action()

func assign_population(buildings, city):
	var population_wanting_work = []
	working_population = []
	resting_population = []
	unemployed_population = []
	for citizen in population:
		if citizen.want_to_work():
			population_wanting_work.append(citizen)
		else:
			resting_population.append(citizen)
	
	var needed_workers_num = 0
	city.reset_population()
	for building in buildings:
		if building.building_components.has("population"):
			building.building_components["population"].reset_population()

	Util.divide_into_requesters(
		population_wanting_work,
		working_population,
		unemployed_population,
		buildings,
		func(requester): 
			if requester.building_components.has("population"):
				return requester.building_components["population"].max_population
			else:
				return 0,
		func(requester, to_assign):
			if requester.building_components.has("population"):
				requester.building_components["population"].assign_population(to_assign)
	)

	city.assign_population(resting_population)
	city.assign_population(unemployed_population)
	for citizen in working_population:
		working_pay(citizen)
	for citizen in unemployed_population:
		unemployed_pay(citizen)
		
