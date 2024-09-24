extends BuildingTile
class_name OutputTile

var input_tile

func _init(building):
	super(building)
	tile_type = TILE_TYPE.OUTPUT

func connect_tile(_input_tile):
	input_tile = _input_tile
	
func unconnect():
	input_tile = null
	
func forward(payload):
	if input_tile != null:
		input_tile.forward(payload)
