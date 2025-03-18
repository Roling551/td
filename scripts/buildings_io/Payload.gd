extends Node
class_name Payload

var substance
var amount

func _init(_substance, _amount):
	substance = _substance
	amount = _amount
	
func get_text():
	return substance + ": " + str(amount)
