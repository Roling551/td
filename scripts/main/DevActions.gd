extends VBoxContainer


@onready var main = get_tree().root.get_node("Main")

var actions = {
	"Turn": func(): main.turn(),
	"Increase population": func(): change_population(10),
	"Decrease population": func(): change_population(-10),
	"Add building": func(): main.main_ui.set_action(add_building_action, LabelUiElement.new("Add building")),
	"Delete building": func(): main.main_ui.set_action(delete_building_action, LabelUiElement.new("Delete building")),
	"Add connection": func(): set_add_connection_action(),
	"Delete connection": func(): main.main_ui.set_action(delete_connection_action, LabelUiElement.new("Delete connection"))
}

func change_population(change):
	main.population_container.change_population(change)

func add_building_action(tile_map, tile_position):
	main.add_building("transformer",tile_map, tile_position)

func delete_building_action(tile_map, tile_position):
	main.buildings_list.delete_building(tile_map, tile_position)

func delete_connection_action(tile_map, tile_position):
	main.connections_list.delete_connection(tile_map, tile_position)

func set_add_connection_action():
	main.main_ui.set_2_point_action(
		func(tile_map, tile_position): 
			var tile = main.buildings_list.tiles.get([tile_map, tile_position])
			return tile != null && BuildingTile.is_tile_connectable(tile),
		func(tile_map, tile_position):
			return main.buildings_list.tiles.get([tile_map, tile_position]),
		func(first_value, first_tile_map, first_tile_position, tile_map, tile_position):
			var second_value = main.buildings_list.tiles.get([tile_map, tile_position])
			if second_value != null && BuildingTile.can_tiles_connect(first_value, second_value):
				main.connections_list.add_connetion(first_value, first_tile_map, first_tile_position, second_value, tile_map, tile_position),
		LabelUiElement.new("Add connection")
	)

func _ready():
	for action_name in actions:
		var button = Button.new()
		button.text = action_name
		button.pressed.connect(actions[action_name])
		add_child(button)
