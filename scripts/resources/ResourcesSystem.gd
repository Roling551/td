extends Node
class_name ResourcesSystem

var resource_types = [
	{
		"name": "food",
		"sprite": "food_sprite"
	},
	{
		"name": "wood",
		"sprite": "wood_sprite"
	},
	{
		"name": "stone",
		"sprite": "stone_sprite"
	}
]

var resources = {}
var resource_items = {}

func _init():
	for resource_type in resource_types:
		resources[resource_type["name"]] = {"current":0.0, "change":SumationDictionary.new()}

func get_ui():
	var updateable_wrap = UpdateableWrap.new(self)
	var ui = VFlowContainer.new()
	ControlUtil.expand_control(ui)
	updateable_wrap.add_child(ui)
	for resource_type in resource_types:
		var item = ControlUtil.create_resource_item_and_add(ui, resource_type["sprite"], 
			func(): 
				return \
					str(snapped(resources[resource_type["name"]]["current"],0.1)) + \
					" (" + \
					str(snapped(resources[resource_type["name"]]["change"].get_sum(),0.1)) + \
					")"
		)
		resource_items[resource_type["name"]] = item
	return updateable_wrap

func update_ui():
	for item in resource_items:
		resource_items[item].update()

func update_resource(key, resource, change, actual):
	if actual:
		resources[resource]["current"] += change
	else:
		resources[resource]["change"].update(key, change)
	MainScript.update_ui.mark_for_update()

func get_resource(resource):
	if resources.has(resource):
		return resources[resource]["current"].get_sum()
	else:
		return 0.0
