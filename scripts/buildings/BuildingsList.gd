extends Node2D
class_name BuildingsList

var tiles = {}
var buildings = []

func get_building_at(tile_map, location):
	if tiles.has([tile_map, location]):
		return tiles[[tile_map, location]].building

func add_building(building_and_tiles, tile_map, location):
	for tile in building_and_tiles["tiles"]:
		if tiles.has([tile_map, location+tile["position"]]):
			return

	for tile in building_and_tiles["tiles"]:
		if tile.has("sprite"):
			var sprite = tile["sprite"]
			var sprite_node = Sprite2D.new()
			sprite_node.texture = sprite["texture"]
			sprite_node.scale = Vector2(sprite["scale"],sprite["scale"])
			tile_map.add_child(sprite_node)
			sprite_node.position = tile_to_world_position(tile_map, location+tile["position"]) + Vector2(sprite["offset_x"], sprite["offset_y"])
		tiles[[tile_map, location+tile["position"]]] = tile["tile"]
	buildings.push_back(building_and_tiles["building"])
	
func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position

func building_actions():
	for building in buildings:
		building.action()
