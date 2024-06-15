extends Control

@onready var label = get_node("HBoxContainer/Label")
@onready var texture_rect = get_node("HBoxContainer/TextureRect")

func set_icon(icon_texture):
	texture_rect.texture = icon_texture
	
func set_text(text):
	label.text = text

