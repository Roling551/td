extends Node2D
class_name BuildingsList

var tiles = {}
var buildings = {}

func get_building_at(tile_map, location):
	if tiles.has([tile_map, location]):
		return tiles[[tile_map, location]].building

func add_building(building_and_tiles, tile_map, location):
	for tile in building_and_tiles["tiles"]:
		if tiles.has([tile_map, location+tile["position"]]):
			return

	var building_node = Node2D.new()
	tile_map.add_child(building_node)
	building_node.position = tile_to_world_position(tile_map, location) + Vector2(-16,-16)
	var building_tiles = {}
	for tile in building_and_tiles["tiles"]:
		if tile.has("sprite"):
			var sprite = tile["sprite"]
			var sprite_node = Sprite2D.new()
			sprite_node.texture = sprite["texture"]
			sprite_node.scale = Vector2(sprite["scale"],sprite["scale"])
			building_node.add_child(sprite_node)
			sprite_node.position = tile_to_world_position(tile_map, tile["position"]) + Vector2(sprite["offset_x"], sprite["offset_y"])
		tiles[[tile_map, location+tile["position"]]] = tile["tile"]
		building_tiles[[tile_map, tile["position"]]] = tile["tile"]
	buildings[building_and_tiles["building"]] = building_node
	building_and_tiles["building"].set_location_and_tiles(location, building_tiles)

func delete_building(tile_map, location):
	var selected_tile = tiles.get([tile_map, location])
	if selected_tile:
		var building = selected_tile.building
		buildings[building].queue_free()
		buildings.erase(building)
		for tile_position in selected_tile.building.tiles:
			tiles.erase([tile_map, building.location+tile_position[1]])

func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position

func building_actions():
	for building in buildings:
		building.action()
