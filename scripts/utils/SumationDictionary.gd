extends Node
class_name SumationDictionary

var dictionary = {}
var _sum = 0

func _init():
	pass
	
func update(key, amount):
	var old_amount = 0
	if dictionary.has(key):
		old_amount = dictionary[key]
	_sum += amount - old_amount
	dictionary[key] = amount

func get_sum():
	return _sum
