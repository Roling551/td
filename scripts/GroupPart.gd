extends Node
class_name GroupPart

var group: Group
var population

func _init(_group, _population):
	group = _group
	population = _population

func add(group_part):
	population += group_part.population
