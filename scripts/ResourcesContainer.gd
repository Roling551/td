extends VFlowContainer

@onready var resource_item_prototype = preload("res://scenes/resource_item.tscn")

var resource_types = [
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
		var item = resource_item_prototype.instantiate()
		add_child(item)
		item.set_icon(resource_type["sprite"])
		resource_items[resource_type["name"]] = item

func update():
	for item in resource_items:
		resource_items[item].set_text(str(snapped(resources[item],0.1)))
		
func change_resource(resource, change):
	resources[resource] += change

