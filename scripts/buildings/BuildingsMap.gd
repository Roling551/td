extends Node3D
class_name BuildingsMap

const sprite_node_prefab = preload("res://scenes/sprite_node.tscn")

#maps coordinates to a tile
var tiles = {}
#maps building to a building node
var buildings = {}

func get_building_at(tile_map, tile_coord):
	if tiles.has([tile_map, tile_coord]):
		return tiles[[tile_map, tile_coord]].building

func place_node(node, tile_map, tile_coord):
	var parent = node.get_parent()
	if tile_map == parent:
		pass
	elif parent == null:
		tile_map.add_child(node)
	else:
		parent.remove_child(node)
		tile_map.add_child(node)
	node.position = ControlUtil.tile_to_world(tile_coord)

func add_building(building_and_tiles, tile_map, tile_coord):
	for tile in building_and_tiles["tiles"]:
		if tiles.has([tile_map, tile_coord+tile["tile_coord"]]):
			return

	var building_node = BuildingSpriteNode.new(building_and_tiles["tiles"])
	tile_map.add_child(building_node)
	building_node.position = ControlUtil.tile_to_world(tile_coord)
	var building_tiles = {}
	for tile in building_and_tiles["tiles"]:
		tiles[[tile_map, tile_coord+tile["tile_coord"]]] = tile["tile"]
		building_tiles[[tile_map, tile["tile_coord"]]] = tile["tile"]
	buildings[building_and_tiles["building"]] = building_node
	building_and_tiles["building"].set_location_and_tiles([tile_map, tile_coord], building_tiles)

func delete_building(tile_map, tile_coord):
	var selected_tile = tiles.get([tile_map, tile_coord])
	if !selected_tile:
		return
	var building = selected_tile.building
	
	buildings[building].queue_free()
	buildings.erase(building)
	if building.building_components.has("input"):
		for tile in building.building_components["input"].inputs:
			MainScript.connections_list.delete_tiles_connection(tile)
	if building.building_components.has("output"):
		for tile in building.building_components["output"].outputs:
			MainScript.connections_list.delete_tiles_connection(tile)
	for tile_location in building.tiles:
		tiles.erase([tile_map, building.location[1]+tile_location[1]])

func building_actions():
	for building in buildings:
		building.action()
