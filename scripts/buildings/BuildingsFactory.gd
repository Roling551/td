extends Node
class_name BuildingsFactory

const sprite_node = preload("res://scenes/sprite_node.tscn")

var buildings_patterns = {
		"transformer":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,0), "sprite_name":"input", "type":BuildingTile.TILE_TYPE.INPUT},
				{"tile_coord": Vector2i(1,-1), "sprite_name":"output", "type":BuildingTile.TILE_TYPE.OUTPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(MainScript.population_container),
				"productivity": func(building): return ProductivityComponent.new(building)
			}
		},
		"provider":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,-1), "sprite_name":"output", "type":BuildingTile.TILE_TYPE.OUTPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(MainScript.population_container),
				"productivity": func(building): return ProductivityComponent.new(building)
			}
		},
		"consumer":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,0), "sprite_name":"input", "type":BuildingTile.TILE_TYPE.INPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(MainScript.population_container),
				"productivity": func(building): return ProductivityComponent.new(building)
			}
		},
	}

func get_building_and_tiles(type):
	
	var pattern = buildings_patterns[type]
	
	var components = {}
	var building = Building.new(components)
	
	var tiles = []
	var inputs = []
	var outputs = []
	for tile in pattern["tiles"]:
		var result_tile = {}
		var tile_instance = BuildingTileFactory.get_tile(tile.get("type"), building)
		result_tile["tile"] = tile_instance
		
		if tile.get("type") == BuildingTile.TILE_TYPE.OUTPUT:
			outputs.append(tile_instance)
		if tile.get("type") == BuildingTile.TILE_TYPE.INPUT:
			inputs.append(tile_instance)
		
		if tile.has("sprite_name"):
			result_tile["sprite_name"]=tile["sprite_name"]
		result_tile["tile_coord"]=tile["tile_coord"]
		tiles.push_back(result_tile)
	
	if type=="transformer" || type=="consumer":
		components["input"] = InputComponent.new(building, inputs)
	
	if type=="transformer" || type=="provider":
		components["output"] = OutputComponent.new(building, outputs)

	if type=="transformer":
		components["transformer"] = TransformerComponent.new(building, inputs[0], outputs[0])
	
	if type=="provider":
		components["provider"] = ProviderComponent.new(building, outputs[0])
	
	if type=="consumer":
		components["consumer"] = ConsumerComponent.new(building, inputs[0])

	

	for component_name in pattern["components"]:
		components[component_name] = pattern["components"][component_name].call(building)
		
	return {
		"building": building,
		"tiles": tiles
	}
	
func get_building_sprite(pattern, tile_map):
	var building_node = Node3D.new()
	for tile in pattern.tiles:
		if tile.has("sprite"):
			var sprite = tile["sprite"]
			var sprite_node = sprite_node.instantiate()
			#sprite_node.texture = sprite["texture"]
			#sprite_node.scale = Vector2(sprite["scale"],sprite["scale"])
			building_node.add_child(sprite_node)
			sprite_node.position = ControlUtil.tile_to_world(tile["tile_coord"])
			#sprite_node.position = MainScript.buildings_map.tile_to_world_position(tile_map, tile["tile_coord"]) + Vector2(sprite["offset_x"], sprite["offset_y"])
	return building_node

func get_pre_build_info(type):
	var pattern = buildings_patterns.get(type)
	var pre_build_info = PreBuildInfo.new(
		func(): return get_building_and_tiles(type),
		pattern,
		func(): return get_building_sprite(pattern, MainScript.tile_map)
	)
	return pre_build_info
