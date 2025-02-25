extends Node3D
class_name BuildingSpriteNode

const sprite_node_prefab = preload("res://scenes/sprite_node.tscn")

func _init(tiles):
	for tile in tiles:
		if tile.has("sprite_name"):
			var sprite_node = sprite_node_prefab.instantiate()
			add_child(sprite_node)
			sprite_node.position = ControlUtil.tile_to_world(tile["tile_coord"]) + Sprites.sprites_3d[tile["sprite_name"]]["offset"]
			sprite_node.set_material_by_name(tile["sprite_name"])
