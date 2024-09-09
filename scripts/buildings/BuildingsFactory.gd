extends Node
class_name BuildingsFactory

func get_buildings_patterns(main_script):
	return [
		{
			"name": "t1",
			"tiles": [
				{"position": Vector2i(0,0), "sprite":"chimney1"},
				{"position": Vector2i(0,-1)},
				{"position": Vector2i(1,0), "sprite":"input", "type":BuildingTile.TILE_TYPE.INPUT},
				{"position": Vector2i(1,-1), "sprite":"output", "type":BuildingTile.TILE_TYPE.OUTPUT},
			],
			"components": {
				"population": func(building): return PopulationComponent.new(main_script.population_container),
				"productivity": func(building): return ProductivityComponent.new(building),
				"resources" : 
					func(building): 
						return ResourcesComponent.new(
							building,
							main_script.resources_container,
							func(productivity):
								main_script.resources_container.change_resource("food", 2*productivity)
						),
			}
		}
	]
