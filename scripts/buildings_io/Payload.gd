extends Node
class_name Payload

var resource
var amount

func _init(_resource, _amount):
	resource = _resource
	amount = _amount
	
func get_text():
	return resource + ": " + str(amount)
