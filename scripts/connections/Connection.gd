extends Node
class_name Connection

var sprite
var input
var input_location
var output
var output_location

func _init(_sprite, _output, _output_location, _input, _input_location):
	sprite = _sprite
	input = _input
	input_location = _input_location
	output = _output
	output_location = _output_location
