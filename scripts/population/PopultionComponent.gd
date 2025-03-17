extends BuildingComponent
class_name PopulationComponent

var container
var label
var population_needed = 0
var max_population_needed = 10

func _init(building : Building):
	super(building)
	building.update_relations.add(building.building_components["pipe"], self)
	update()

func has_ui():
	return true

func action():
	pass

func activate_ui():
	var c = ControlUtil.get_expanded_control()
	label = Label.new()
	c.add_child(label)
	return c

func update():
	if building.building_components["pipe"].is_turned_on():
		population_needed = max_population_needed
	else:
		population_needed = 0
	MainScript.update_ui.mark_for_update()

func update_ui():
	label.text = "workers: " + str(population_needed) + " / " + str(max_population_needed)
