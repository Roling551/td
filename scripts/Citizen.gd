extends Node
class_name Citizen

var rest = 1.0

func change_rest(change):
	rest = clamp(rest+change, 0.0, 1.0)
