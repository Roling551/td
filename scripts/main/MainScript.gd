extends Node2D

@onready var tile_map = get_node("TileMap")
@onready var camera = get_node("Camera2D")
@onready var tile_map_actions = TileMapActions.new(camera)
@export var resources_container : Node
@export var population_container : Node
@export var time_container : Node
@export var active_panel : Node
@onready var building_factory = BuildingsFactory.new(self)
#@onready var buildings_patterns = building_factory.get_buildings_patterns()
@onready var buildings_list = BuildingsList.new(self)
@onready var connections_list = ConnectionsList.new(self)
@onready var main_ui = MainUI.new(self)

func add_building(type, tile_map, tile_position):
	buildings_list.add_building(building_factory.get_building_and_tiles(type), tile_map, tile_position)

func _ready():
	add_child(main_ui)

	add_building("provider", tile_map, Vector2i(-3,1))
	add_building("transformer", tile_map, Vector2i(0,1))
	add_building("consumer", tile_map, Vector2i(3,1))

func turn():
	time_container.proceed_turn()
	population_container.assign_population(buildings_list.buildings)
	buildings_list.building_actions()
	population_container.citizens_action()
	update()
	
func update():
	resources_container.update()
	population_container.update()
	main_ui.update_ui()	

func _physics_process(delta):
	pass
