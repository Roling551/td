extends VBoxContainer


@onready var main = get_tree().root.get_node("Main")

var actions = {
	"Increase population": func(): change_population(10),
	"Decrease population": func(): change_population(-10),
}

func change_population(change):
	main.population_container.change_population(change)
	main.population_container.assign_population(main.buildings_list.buildings)

func _ready():
	for action_name in actions:
		var button = Button.new()
		button.text = action_name
		button.pressed.connect(actions[action_name])
		add_child(button)
