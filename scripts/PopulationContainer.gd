extends VFlowContainer
class_name PopulationContainer

@export var resource_container: Node

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")
@onready var population_sprite = preload("res://sprites/resource_sprites/rat.png")
@onready var working_sprite = preload("res://sprites/resource_sprites/working.png")
@onready var unemployed_sprite = preload("res://sprites/resource_sprites/unemployed.png")
@onready var bed_sprite = preload("res://sprites/resource_sprites/bed.png")
@onready var stomach_sprite = preload("res://sprites/resource_sprites/stomach.png")

var population = []
var working_population = []
var resting_population = []
var unemployed_population = []

var resource_items = {}

func _ready():
	create_resource_item("population", population_sprite, func():return population.size())
	create_resource_item("working", working_sprite, func():return working_population.size())
	create_resource_item("rest", bed_sprite, func():return resting_population.size())
	create_resource_item("unemployed", unemployed_sprite, func():return unemployed_population.size())
	create_resource_item("satiety", stomach_sprite, func():return Util.get_avg(population, func(citizen): return citizen.needs["satiety"]))
	update()

func update():
	for item in resource_items:
		resource_items[item][0].set_text(str(resource_items[item][1].call()))

func create_resource_item(name, sprite, update_method):
	var resource_item = resource_item_prototype.instantiate()
	add_child(resource_item)
	resource_item.set_icon(sprite)
	resource_items[name] = [resource_item, update_method]
	return resource_item

func change_population(population_change):
	if population_change>0:
		for i in population_change:
			population.append(Citizen.new())

func citizens_action():
	for citizen in population:
		citizen.action()

func assign_population(buildings, city):
	AssignResourcesToPopulation.basic_assign(self, resource_container)
	AssignPopulationAlgorithms.assign_equally(population, working_population, resting_population, unemployed_population, buildings, city)
	
		
