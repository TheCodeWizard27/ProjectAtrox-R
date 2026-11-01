class_name HostPlayerUpdatePacket

var position: Vector3
var rotation: Vector3

func _init(p_position: Vector3, p_rotation: Vector3):
	position = p_position
	rotation = p_rotation

static func from_payload(payload: Dictionary) -> HostPlayerUpdatePacket:
	return HostPlayerUpdatePacket.new(
		PacketHelper.parse_vector(payload.get('pos')),
		PacketHelper.parse_vector(payload.get('rot'))
	)

static func from_player(player: Player) -> Dictionary:
	return {
		'pos': PacketHelper.stringify_vector(player.body.global_position),
		'rot': PacketHelper.stringify_vector(player.body.rotation)
	}
