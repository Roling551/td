extends Control

@onready var label = get_node("HBoxContainer/Label")
@onready var texture_rect = get_node("HBoxContainer/TextureRect")

var update_method

func _set_icon(icon_texture):
	texture_rect.texture = icon_texture
	
func _set_text(text):
	label.text = text

func _set_update_method(method):
	update_method = method
	
func update():
	_set_text(update_method.call())
