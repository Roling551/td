extends Node2D

@onready var tile_map = get_node("TileMap")
@onready var camera = get_node("Camera2D")
@onready var tile_map_actions = TileMapActions.new(camera)
@export var resources_container : Node
@export var population_container : Node
@export var active_panel : Node
@onready var buildings_patterns = BuildingsFactory.new().get_buildings_patterns(self)
@onready var buildings_list = BuildingsList.new()
@onready var main_ui = MainUI.new(self)

func add_building(tile_map, tile_position):
	buildings_list.create_building(buildings_patterns[0], tile_map, tile_position)

func _ready():
	add_child(main_ui)
	add_building(tile_map, Vector2i(1,1))
	add_building(tile_map, Vector2i(2,1))
	add_building(tile_map, Vector2i(3,1))

func _physics_process(delta):
	buildings_list.building_actions()
	resources_container.update()
	population_container.update()
	main_ui.update_ui()
