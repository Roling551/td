extends Node
class_name ConnectionsList

var connections = {}

const sprite_node_prefab = preload("res://scenes/sprite_node.tscn")

func add_connetion(tile_1, tile_map_1, tile_coord_1, tile_2, tile_map_2, tile_coord_2):
	if BuildingTile.is_tile_input(tile_1):
		_add_connection_sorted(tile_2, tile_map_2, tile_coord_2, tile_1, tile_map_1, tile_coord_1)
	else:
		_add_connection_sorted(tile_1, tile_map_1, tile_coord_1, tile_2, tile_map_2, tile_coord_2)

	
func _add_connection_sorted(tile_o, tile_map_o, tile_coord_o, tile_i, tile_map_i, tile_coord_i):
	var sprite = Sprites.sprites["pipe_sprite"]
	var sprite_node = Sprite3D.new()
	sprite_node.texture = sprite
	#sprite_node.scale = Vector3(0.5, 0.5, 1.0)
	tile_map_i.add_child(sprite_node)
	var position_o = ControlUtil.tile_to_world(tile_coord_o)
	var position_i = ControlUtil.tile_to_world(tile_coord_i)
	sprite_node.position = position_o.lerp(position_i, 0.5)
	sprite_node.position.z += 0.1
	sprite_node.region_enabled = true
	sprite_node.pixel_size = 0.0156
	var length = sqrt(pow(tile_coord_o.x-tile_coord_i.x,2) + pow(tile_coord_o.y-tile_coord_i.y,2))
	sprite_node.region_rect = Rect2(0,0,64 * length,64)
	print(position_o, position_i)
	print(sprite_node.position)
	print(sprite_node.rotation)
	#print(position_o.direction_to(position_i))
	
	var rotation = Util.v3_to_v2(position_o).direction_to(Util.v3_to_v2(position_i)).angle()
	
	sprite_node.rotation = Vector3(0,0,rotation)

	print(sprite_node.rotation)
	#sprite_node.rotation = position_o.direction_to(position_i)
	
	var connection = Connection.new(sprite_node, tile_o, [tile_map_o, tile_coord_o], tile_i, [tile_map_i, tile_coord_i])
	connections[tile_o] = connection
	connections[tile_i] = connection
	tile_i.connect_tile(tile_o, connection)
	tile_o.connect_tile(tile_i, connection)
	
func delete_tiles_connection(tile):
	if !tile || !("connection" in tile):
		return
	var connection: Connection = tile.connection
	if connection == null:
		return
	connection.sprite.queue_free()
	connection.input.unconnect()
	connection.output.unconnect()
	connections.erase(connection.input_location)
	connections.erase(connection.output_location)
	

func delete_connection(tile_map, tile_coord):
	var tile = MainScript.buildings_map.tiles.get([tile_map, tile_coord])
	delete_tiles_connection(tile)

func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position
