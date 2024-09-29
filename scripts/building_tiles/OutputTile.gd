extends BuildingTile
class_name OutputTile

var input_tile
var connection

func _init(building):
	super(building)
	tile_type = TILE_TYPE.OUTPUT

func connect_tile(_input_tile, _connection):
	input_tile = _input_tile
	connection = _connection
	
func unconnect():
	input_tile = null
	connection = null
	
func forward(payload):
	if input_tile != null:
		input_tile.forward(payload)
