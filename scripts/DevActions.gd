extends VBoxContainer


@onready var main = get_tree().root.get_node("Main")

var actions = {
	"Increase population": func(): change_population(10),
	"Decrease population": func(): change_population(-10),
	"Add building": func(): main.main_ui.set_action(add_building_action)
}

func change_population(change):
	main.population_container.change_population(change)

func add_building_action(tile_map, tile_position):
	main.buildings_list.create_building(main.buildings_patterns[0], tile_map, tile_position)

func _ready():
	for action_name in actions:
		var button = Button.new()
		button.text = action_name
		button.pressed.connect(actions[action_name])
		add_child(button)
