extends VFlowContainer
class_name PopulationContainer

@export var resource_container: Node

var citizen_groups = {}

var resource_items = {}

func _ready():
	citizen_groups["settlers"] = Group.new(20)
	resource_items[name] =  ControlUtil.create_resource_item(self, "population_sprite", func():
		return str(citizen_groups["settlers"].population, " (", citizen_groups["settlers"].avaliable_population, ")")
	)
	update()

func update():
	for item in resource_items:
		resource_items[item].update()

func change_population(population_change):
	citizen_groups["settlers"].change_population(population_change)
	update()

func citizens_action():
	pass
	#for citizen in population:
	#	citizen.action()

func assign_population(buildings):
	AssignPopulationAlgorithms.assign_equally(self, resource_container, buildings)
