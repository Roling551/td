extends VBoxContainer


@onready var main = get_tree().root.get_node("Main")

var actions = {
	"Turn": func(): main.turn(),
	"Increase population": func(): change_population(10),
	"Decrease population": func(): change_population(-10),
	"Add building": func(): main.main_ui.set_action(add_building_action),
	"Add connection": func(): set_add_connection_action();
}

func change_population(change):
	main.population_container.change_population(change)

func add_building_action(tile_map, tile_position):
	main.add_building("transformer",tile_map, tile_position)

func set_add_connection_action():
	main.main_ui.set_2_point_action(
		func(tile_map, tile_position): 
			var tile = main.buildings_list.tiles.get([tile_map, tile_position])
			return tile != null && BuildingTile.is_tile_connectable(tile),
		func(tile_map, tile_position):
			return main.buildings_list.tiles.get([tile_map, tile_position]),
		func(first_value, tile_map, tile_position):
			var second_value = main.buildings_list.tiles.get([tile_map, tile_position])
			if second_value != null && BuildingTile.can_tiles_connect(first_value, second_value):
				first_value.connect_tile(second_value)
				second_value.connect_tile(first_value)
	)

func _ready():
	for action_name in actions:
		var button = Button.new()
		button.text = action_name
		button.pressed.connect(actions[action_name])
		add_child(button)
