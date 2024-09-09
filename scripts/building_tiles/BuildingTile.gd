extends Node
class_name BuildingTile

enum TILE_TYPE { NORMAL, INPUT, OUTPUT }

var tile_type : TILE_TYPE
var building: Building

func _init(_building: Building):
	building = _building
	tile_type = TILE_TYPE.NORMAL

static func is_tile_connectable(tile):
	return tile.tile_type == TILE_TYPE.INPUT || tile.tile_type == TILE_TYPE.OUTPUT

static func can_tiles_connect(tile_1, tile_2):
	return (tile_1.tile_type == TILE_TYPE.INPUT && tile_2.tile_type == TILE_TYPE.OUTPUT) || (tile_2.tile_type == TILE_TYPE.INPUT && tile_1.tile_type == TILE_TYPE.OUTPUT)
