extends VBoxContainer
class_name DevActions

var buttons = [
	ActionButton.new("Turn", func(): MainScript.turn()),
	ActionButton.new("Increase population", func(): change_population(10)),
	ActionButton.new("Decrease population", func(): change_population(-10)),
	ActionButton.new("Add building", func(): set_add_building_action(MainScript.building_factory.get_pre_build_info("transformer"))),
	ActionButton.new("Delete building", func(): MainScript.main_ui.set_action(delete_building_action, LabelUiElement.new("Delete building"))),
	ActionButton.new("Add connection", func(): set_add_connection_action()),
	ActionButton.new("Delete connection", func(): MainScript.main_ui.set_action(delete_connection_action, LabelUiElement.new("Delete connection"))),
	ControlUtil.get_go_and_back("Build", self, BuildingsList.new())
]

var pre_build_info

func change_population(change):
	MainScript.population_system.change_population(change)

func set_add_building_action(pre_build_info):
	MainScript.main_ui.set_action(
		func(tile_map, tile_coord):
			MainScript.buildings_map.add_building(pre_build_info.create_building_and_tiles(), tile_map, tile_coord)
			LabelUiElement.new("Add building")
	)
	var pattern = pre_build_info.pattern
	var graphic_node = pre_build_info.create_graphic_node_tiles()
	MainScript.main_ui.set_hover_tile_function(
		func(tile_map, tile_coord):
			MainScript.buildings_map.place_node(graphic_node, tile_map, tile_coord)
	)
	MainScript.main_ui.set_deselect_action_function(
		func():
			graphic_node.queue_free()
	)

func delete_building_action(tile_map, tile_coord):
	MainScript.buildings_map.delete_building(tile_map, tile_coord)

func delete_connection_action(tile_map, tile_coord):
	MainScript.connections_list.delete_connection(tile_map, tile_coord)

func set_add_connection_action():
	MainScript.main_ui.set_2_point_action(
		func(tile_map, tile_coord): 
			var tile = MainScript.buildings_map.tiles.get([tile_map, tile_coord])
			return tile != null && BuildingTile.is_tile_connectable(tile),
		func(tile_map, tile_coord):
			return MainScript.buildings_map.tiles.get([tile_map, tile_coord]),
		func(first_value, first_tile_map, first_tile_coord, tile_map, tile_coord):
			var second_value = MainScript.buildings_map.tiles.get([tile_map, tile_coord])
			if second_value != null && BuildingTile.can_tiles_connect(first_value, second_value):
				MainScript.connections_list.add_connetion(first_value, first_tile_map, first_tile_coord, second_value, tile_map, tile_coord),
		LabelUiElement.new("Add connection")
	)

func add_building_by_type(type, tile_map, tile_coord):
	MainScript.buildings_map.add_building(MainScript.building_factory.get_building_and_tiles(type), tile_map, tile_coord)

func add_building(buildig, tile_map, tile_coord):
	MainScript.buildings_map.add_building(buildig, tile_map, tile_coord)

func _ready():
	ControlUtil.set_anchor_full_rect(self)
	for button in buttons:
		add_child(button)
