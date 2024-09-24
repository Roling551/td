extends Node
class_name ConnectionsList

var connections = {}

func add_connetion(tile_1, tile_map_1, location_1, tile_2, tile_map_2, location_2):
	if BuildingTile.is_tile_input(tile_1):
		print("input")
		_add_connection_sorted(tile_2, tile_map_2, location_2, tile_1, tile_map_1, location_1)
	else:
		_add_connection_sorted(tile_1, tile_map_1, location_1, tile_2, tile_map_2, location_2)

	
func _add_connection_sorted(tile_o, tile_map_o, location_o, tile_i, tile_map_i, location_i):
	var sprite = Sprites.sprites["pipe_sprite"]
	var sprite_node = Sprite2D.new()
	sprite_node.texture = sprite
	sprite_node.scale = Vector2(0.5, 0.5)
	tile_map_i.add_child(sprite_node)
	var position_o = tile_to_world_position(tile_map_o, location_o)
	var position_i = tile_to_world_position(tile_map_i, location_i)
	sprite_node.position = position_o.lerp(position_i, 0.5)
	sprite_node.region_enabled = true
	sprite_node.texture_repeat = CanvasItem.TextureRepeat.TEXTURE_REPEAT_ENABLED
	sprite_node.z_index = 2
	var length = sqrt(pow(location_o.x-location_i.x,2) + pow(location_o.y-location_i.y,2))
	sprite_node.region_rect = Rect2(0,0,64 * length,64)
	sprite_node.rotation = position_o.direction_to(position_i).angle()
	
	var connection = Connection.new(sprite_node, tile_o, [tile_map_o, location_o], tile_i, [tile_map_i, location_i])
	connections[[tile_map_o, location_o]] = connection
	connections[[tile_map_i, location_i]] = connection

func delete_connection(tile_map, tile_location):
	var connection: Connection = connections.get([tile_map, tile_location])
	if connection == null:
		return	
	tile_map.remove_child(connection.sprite)
	connection.sprite.queue_free()
	connection.input.unconnect()
	connection.output.unconnect()
	connections.erase(connection.input_location)
	connections.erase(connection.output_location)

func tile_to_world_position(tile_map, tile_pos):
	return tile_map.map_to_local(tile_pos) + tile_map.global_position
