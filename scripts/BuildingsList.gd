extends Node2D
class_name BuildingsList

var tiles = {}
var buildings = []
	
var sprites = {
	"chimney1": {
		"texture": preload("res://sprites/building_sprites/chimney1.png"),
		"scale": 0.5,
		"offset_x": 0,
		"offset_y": -16
	}
}

func get_building_at(tile_map, location):
	if tiles.has([tile_map, location]):
		return tiles[[tile_map, location]]

func create_building(building_pattern, tile_map, location):
	for tile in building_pattern["tiles"]:
		if tiles.has(location+tile["position"]):
			return

	var components = {}
	for component_name in building_pattern["components"]:
		components[component_name] = building_pattern["components"][component_name].call()

	var building = Building.new(components)

	for tile in building_pattern["tiles"]:
		if tile.has("sprite"):
			var sprite_node = Sprite2D.new()
			var sprite = sprites[tile["sprite"]]
			sprite_node.texture = sprite["texture"]
			sprite_node.scale = Vector2(sprite["scale"],sprite["scale"])
			tile_map.add_child(sprite_node)
			sprite_node.position = tile_to_world_position(tile_map, location+tile["position"]) + Vector2(sprite["offset_x"], sprite["offset_y"])
		tiles[[tile_map, location+tile["position"]]] = building
	buildings.push_back(building)
	
func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position

func building_actions():
	for building in buildings:
		building.action()
