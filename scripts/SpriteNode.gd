extends MeshInstance3D

func set_material(sprite_name):
	var sprite = Sprites.sprites_3d[sprite_name]
	set_surface_override_material(0, sprite["material"])
	scale = sprite["scale"]
