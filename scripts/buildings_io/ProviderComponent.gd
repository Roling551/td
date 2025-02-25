extends BuildingComponent
class_name ProviderComponent

var building
var output: OutputTile

func _init(_building, _output):
	building = _building
	output = _output
	building.functionalities["turn_action"] = func(): 
		output.forward("test")
