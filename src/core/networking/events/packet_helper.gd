class_name PacketHelper

static func create_packet(type: int, payload: Dictionary) -> PackedByteArray:
	var packet = StreamPeerBuffer.new()
	packet.put_8(type)
	packet.put_data(JSON.stringify(payload).to_utf8_buffer())
	return packet.data_array

static func get_payload(packet: PackedByteArray) -> Dictionary:
	return JSON.parse_string(packet.slice(1).get_string_from_utf8())

static func is_type(packet: PackedByteArray, type: int) -> bool:
	return get_type(packet) == type

static func get_type(packet: PackedByteArray) -> int:
	return packet.decode_u8(0)

static func stringify_vector(vector: Vector3) -> Array[float]:
	return [vector.x, vector.y, vector.z]

# Keep Array generic or else its more cumbersome to parse
static func parse_vector(array: Array) -> Vector3:
	return Vector3(array[0], array[1], array[2])
