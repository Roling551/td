extends Node
class_name ControlUtil

const resource_item_prototype = preload("res://scenes/resource_item.tscn")

static func create_resource_item(obj, sprite, update_method):
	var resource_item = resource_item_prototype.instantiate()
	obj.add_child(resource_item)
	resource_item._set_icon(sprite)
	resource_item._set_update_method(update_method)
	return resource_item
