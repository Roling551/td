extends Control

@onready var label = get_node("HBoxContainer/Label")
@onready var texture_rect = get_node("HBoxContainer/TextureRect")
var icon_texture
var text

var update_method

func _ready():
	if texture_rect:
		texture_rect.texture = icon_texture
	if label && text:
		label.text = text

func _set_icon(_icon_texture):
	icon_texture = _icon_texture
	if texture_rect:
		texture_rect.texture = icon_texture
	
func _set_text(_text):
	text = _text
	if label:
		label.text = text

func _set_update_method(method):
	update_method = method
	
func update():
	_set_text(update_method.call())
