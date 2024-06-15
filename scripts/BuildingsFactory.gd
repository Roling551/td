extends Node
class_name BuildingsFactory

func get_buildings_patterns(main_script):
	return [
		{
			"name": "t1",
			"tiles": [
				{"position": Vector2i(0,0), "sprite":"chimney1"},
				{"position": Vector2i(0,-1)}
			],
			"components": {
				"resources" : func(): return ResourcesComponent.new(main_script.resources_container),
				"population": func(): return PopulationComponent.new(),
			}
		}
	]
