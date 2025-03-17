extends Node
class_name OneToMany

var dictionary = {}

func add(key, value):
	if dictionary.has(key):
		dictionary[key].append(value)
	else:
		dictionary[key] = [value]

func get_array(key):
	return dictionary[key]
