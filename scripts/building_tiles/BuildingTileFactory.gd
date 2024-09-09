extends Node
class_name BuildingTileFactory

static func get_tile(type, building: Building):
	if type == BuildingTile.TILE_TYPE.INPUT:
		return InputTile.new(building)
	if type == BuildingTile.TILE_TYPE.OUTPUT:
		return OutputTile.new(building)
	else:
		return BuildingTile.new(building)
