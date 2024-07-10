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
				"resources" : 
					func(): 
						return ResourcesComponent.new(
							main_script.resources_container,
							func():
								main_script.resources_container.change_resource("food", 0.02)
						),
				"population": func(): return PopulationComponent.new(main_script.population_container),
			}
		}
	]
