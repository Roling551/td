extends VBoxContainer
class_name BuildingsList

var buildings = {
	"Provider": MainScript.building_factory.get_pre_build_info("provider"),
	"Consumer": MainScript.building_factory.get_pre_build_info("consumer"),
	"Transformer": MainScript.building_factory.get_pre_build_info("transformer"),
	"Transformer X": MainScript.building_factory.get_pre_build_info("transformer_x")
}

func _init():
	ControlUtil.set_anchor_full_rect(self)
	for building in buildings:
		var info = buildings[building]
		var button = ActionButton.new(building, func(): MainScript.dev_actions.set_add_building_action(info))
		add_child(button)
