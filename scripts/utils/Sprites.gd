extends Node
class_name Sprites

const sprites = {
	#resoures
	"population_sprite": preload("res://sprites/resource_sprites/rat.png"),
	"working_sprite": preload("res://sprites/resource_sprites/working.png"),
	"unemployed_sprite": preload("res://sprites/resource_sprites/unemployed.png"),
	"bed_sprite": preload("res://sprites/resource_sprites/bed.png"),
	"stomach_sprite": preload("res://sprites/resource_sprites/stomach.png"),
	"time_sprite": preload("res://sprites/resource_sprites/time.png"),
	"date_sprite": preload("res://sprites/resource_sprites/date.png"),
	"stone_sprite": preload("res://sprites/resource_sprites/stone.png"),
	"wood_sprite": preload("res://sprites/resource_sprites/wood.png"),
	"food_sprite": preload("res://sprites/resource_sprites/food.png"),
	#other
	"pipe_sprite": preload("res://sprites/pipe.png"),
}

const base_material = preload("res://base_material.tres")

const _sprites_3d = {
	"chimney": {
		"texture": preload("res://sprites/building_sprites/chimney1.png"), 
		"offset":Vector3(0,-0.5,0)
	},
	"input": {"texture": preload("res://sprites/building_sprites/input.png")},
	"output": {"texture": preload("res://sprites/building_sprites/output.png")}
}

static var sprites_3d = get_materials()

static func get_materials():
	var sprites_3d = {}
	for material_name in _sprites_3d:
		var texture = _sprites_3d[material_name]["texture"]
		var sprite = {}
		sprite["scale"] = Vector3(texture.get_width()/64.0, texture.get_height()/64.0, 1.0)
		if _sprites_3d[material_name].has("offset"):
			sprite["offset"] = _sprites_3d[material_name]["offset"]
		else:
			sprite["offset"] = Vector3(0,0,0)
		var material = base_material.duplicate()
		material.albedo_texture = texture
		sprite["material"] = material
		sprites_3d[material_name] = sprite
	return sprites_3d
