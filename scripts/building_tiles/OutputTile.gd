extends BuildingTile
class_name OutputTile

var input_tile
var connection
var payload

func _init(building):
	super(building)
	tile_type = TILE_TYPE.OUTPUT

func connect_tile(_input_tile, _connection):
	input_tile = _input_tile
	connection = _connection
	_forward(false, payload)
	MainScript.update_ui.mark_for_update()
	
func unconnect():
	_forward(false, null)
	input_tile = null
	connection = null
	MainScript.update_ui.mark_for_update()
	
func forward(actual, _payload):
	payload = _payload
	_forward(actual, payload)
	
func _forward(actual, _payload):
	if input_tile != null:
		input_tile.forward(actual, _payload)
