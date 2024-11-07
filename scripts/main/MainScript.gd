extends Node2D
class_name MainScript

static var resources_container : Node
static var population_container : Node
static var time_container : Node
static var active_panel : Node
static var tile_map
static var camera
static var tile_map_actions
static var building_factory
static var buildings_list = BuildingsList.new()
static var connections_list
static var main_ui
static var update_ui = UpdateUI.new()

func add_building(type, tile_map, tile_coord):
	buildings_list.add_building(building_factory.get_building_and_tiles(type), tile_map, tile_coord)
func _ready():
	active_panel =  get_node("CanvasLayer/VBoxContainer/BottomPanel/Panel")
	tile_map = get_node("TileMap")
	camera = get_node("Camera2D")
	resources_container = get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/ResourcesContainer")
	population_container = get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/PopulationContainer")
	time_container =  get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/TimeContainer")
	tile_map_actions = TileMapActions.new(camera)
	building_factory = BuildingsFactory.new()
	connections_list = ConnectionsList.new()
	main_ui = MainUI.new()

	add_child(main_ui)
	add_child(update_ui)
	
	add_building("provider", tile_map, Vector2i(-3,1))
	add_building("transformer", tile_map, Vector2i(0,1))
	add_building("consumer", tile_map, Vector2i(3,1))

func turn():
	time_container.proceed_turn()
	population_container.assign_population(buildings_list.buildings)
	buildings_list.building_actions()
	population_container.citizens_action()

func _physics_process(delta):
	pass
