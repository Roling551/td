extends VFlowContainer
class_name ResourcesContainer

var resource_types = [
	{
		"name": "food",
		"sprite": preload("res://sprites/resource_sprites/food.png")
	},
	{
		"name": "wood",
		"sprite": preload("res://sprites/resource_sprites/wood.png")
	},
	{
		"name": "stone",
		"sprite": preload("res://sprites/resource_sprites/stone.png")
	}
]

var resources = {}
var resource_items = {}

func _ready():
	for resource_type in resource_types:
		resources[resource_type["name"]] = 0
		var item = ControlUtil.create_resource_item(self, resource_type["sprite"], func(): return str(snapped(resources[resource_type["name"]],0.1)))
		resource_items[resource_type["name"]] = item

func update():
	for item in resource_items:
		resource_items[item].update()

func change_resource(resource, change):
	resources[resource] += change

func get_resource(resource):
	if resources.has(resource):
		return resources[resource]
	else:
		return 0.0
