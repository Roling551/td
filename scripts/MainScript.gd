extends Node2D

@onready var tile_map = get_node("TileMap")
@onready var camera = get_node("Camera2D")
@onready var tile_map_actions = TileMapActions.new(camera)
@onready var resources_container = get_node("CanvasLayer/Control/HBoxContainer/ResourcesContainer")
@onready var buildings_patterns = BuildingsFactory.new().get_buildings_patterns(self)
@onready var buildings_list = BuildingsList.new()

func add_building(tile_map, tile_position):
	buildings_list.create_building(buildings_patterns[0], tile_map, tile_position)

func _ready():
	tile_map_actions.set_click_function(add_building)

func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		tile_map_actions.handle_click(tile_map, event)

func _physics_process(delta):
	buildings_list.building_actions()
	resources_container.update()
