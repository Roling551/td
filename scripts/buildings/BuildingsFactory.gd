extends Node
class_name BuildingsFactory

var main_script

func _init(_main_script):
	main_script = _main_script
	for pattern in buildings_patterns:
		for tile in buildings_patterns[pattern]["tiles"]:	
			if tile.has("sprite_name"):
				tile["sprite"]=sprites[tile["sprite_name"]]

var sprites = {
	"chimney1": {
		"texture": preload("res://sprites/building_sprites/chimney1.png"),
		"scale": 0.5,
		"offset_x": 0,
		"offset_y": -16
	},
	"input": {
		"texture": preload("res://sprites/building_sprites/input.png"),
		"scale": 0.5,
		"offset_x": 0,
		"offset_y": 0
	},
	"output": {
		"texture": preload("res://sprites/building_sprites/output.png"),
		"scale": 0.5,
		"offset_x": 0,
		"offset_y": 0
	}
}

var buildings_patterns = {
		"transformer":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney1"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,0), "sprite_name":"input", "type":BuildingTile.TILE_TYPE.INPUT},
				{"tile_coord": Vector2i(1,-1), "sprite_name":"output", "type":BuildingTile.TILE_TYPE.OUTPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(main_script.population_container),
				"productivity": func(building): return ProductivityComponent.new(building)
			}
		},
		"provider":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney1"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,-1), "sprite_name":"output", "type":BuildingTile.TILE_TYPE.OUTPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(main_script.population_container),
				"productivity": func(building): return ProductivityComponent.new(building)
			}
		},
		"consumer":{
			"name": "t1",
			"tiles": [
				{"tile_coord": Vector2i(0,0), "sprite_name":"chimney1"},
				{"tile_coord": Vector2i(0,-1)},
				{"tile_coord": Vector2i(1,0), "sprite_name":"input", "type":BuildingTile.TILE_TYPE.INPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(main_script.population_container),
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
		
		if tile.has("sprite"):
			result_tile["sprite"]=tile["sprite"]
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





