extends VBoxContainer


@onready var main = get_tree().root.get_node("Main")

var actions = {
	"Turn": func(): main.turn(),
	"Increase population": func(): change_population(10),
	"Decrease population": func(): change_population(-10),
	"Add building": func(): set_add_building_action(),
	"Delete building": func(): main.main_ui.set_action(delete_building_action, LabelUiElement.new("Delete building")),
	"Add connection": func(): set_add_connection_action(),
	"Delete connection": func(): main.main_ui.set_action(delete_connection_action, LabelUiElement.new("Delete connection"))
}

func change_population(change):
	main.population_container.change_population(change)

func set_add_building_action():
	var type = "transformer"
	main.main_ui.set_action(
		func(tile_map, tile_coord):
			main.add_building(type,tile_map, tile_coord),
		LabelUiElement.new("Add building")
	)
	var pattern = main.building_factory.buildings_patterns.get(type)
	var sprite_node = main.buildings_list.get_building_sprite(pattern, main.tile_map)
	main.main_ui.set_hover_tile_function(
		func(tile_map, tile_coord):
			main.buildings_list.place_node(sprite_node, tile_map, tile_coord)
	)
	main.main_ui.set_deselect_action_function(
		func():
			sprite_node.queue_free()
	)

func delete_building_action(tile_map, tile_coord):
	main.buildings_list.delete_building(tile_map, tile_coord)

func delete_connection_action(tile_map, tile_coord):
	main.connections_list.delete_connection(tile_map, tile_coord)

func set_add_connection_action():
	main.main_ui.set_2_point_action(
		func(tile_map, tile_coord): 
			var tile = main.buildings_list.tiles.get([tile_map, tile_coord])
			return tile != null && BuildingTile.is_tile_connectable(tile),
		func(tile_map, tile_coord):
			return main.buildings_list.tiles.get([tile_map, tile_coord]),
		func(first_value, first_tile_map, first_tile_coord, tile_map, tile_coord):
			var second_value = main.buildings_list.tiles.get([tile_map, tile_coord])
			if second_value != null && BuildingTile.can_tiles_connect(first_value, second_value):
				main.connections_list.add_connetion(first_value, first_tile_map, first_tile_coord, second_value, tile_map, tile_coord),
		LabelUiElement.new("Add connection")
	)

func _ready():
	for action_name in actions:
		var button = Button.new()
		button.text = action_name
		button.pressed.connect(actions[action_name])
		add_child(button)
