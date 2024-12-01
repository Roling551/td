extends Node2D
class_name MainScript

static var resources_container : Node
static var population_container : Node
static var time_container : Node
static var active_panel : Node
static var left_panel : Node
static var tile_map
static var camera
static var tile_map_actions
static var building_factory
static var buildings_map = BuildingsMap.new()
static var connections_list
static var main_ui
static var update_ui = UpdateUI.new()
static var dev_actions

func _ready():
	active_panel =  get_node("CanvasLayer/VBoxContainer/BottomPanel/Panel")
	tile_map = get_node("TileMap")
	camera = get_node("Camera2D")
	resources_container = get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/ResourcesContainer")
	population_container = get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/PopulationContainer")
	time_container = get_node("CanvasLayer/VBoxContainer/UpperPanel/Panel/HBoxContainer/TimeContainer")
	tile_map_actions = TileMapActions.new(camera)
	building_factory = BuildingsFactory.new()
	connections_list = ConnectionsList.new()
	main_ui = MainUI.new()
	left_panel = get_node("CanvasLayer/VBoxContainer/MiddlePart/LeftPanel")

	add_child(main_ui)
	add_child(update_ui)
	
	dev_actions = DevActions.new()
	
	dev_actions.add_building_by_type("provider", tile_map, Vector2i(-3,1))
	dev_actions.add_building_by_type("transformer", tile_map, Vector2i(0,1))
	dev_actions.add_building_by_type("consumer", tile_map, Vector2i(3,1))
	
	left_panel.add_child(dev_actions)

static func turn():
	time_container.proceed_turn()
	population_container.assign_population(buildings_map.buildings)
	buildings_map.building_actions()
	population_container.citizens_action()

func _physics_process(delta):
	pass
