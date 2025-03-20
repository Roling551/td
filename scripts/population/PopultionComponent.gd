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

func get_population_needed():
	if building.building_components["pipe"].is_turned_on():
		return max_population_needed
	else:
		return 0
	
func update():
	var needed_previously = population_needed

	MainScript.population_system.change_populaion_needed(self, get_population_needed())
	MainScript.update_ui.mark_for_update()

func update_ui():
	label.text = "workers: " + str(population_needed) + " / " + str(max_population_needed)
	
func before_delete():
	MainScript.population_system.change_populaion_needed(self, 0)
