extends BuildingTile
class_name InputTile

var payload
var connection

func _init(building):
	super(building)
	tile_type = TILE_TYPE.INPUT

func forward(actual, _payload):
	payload = _payload
	building.building_components["input"].activate(actual, self)

func connect_tile(_output_tile, _connection):
	connection = _connection

func unconnect():
	connection = null
