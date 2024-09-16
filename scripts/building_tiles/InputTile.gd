extends BuildingTile
class_name InputTile

var payload

func _init(building):
	super(building)
	tile_type = TILE_TYPE.INPUT

func forward(_payload):
	payload = _payload
	building.building_components["input"].activate(self)

func connect_tile(_output_tile):
	pass
