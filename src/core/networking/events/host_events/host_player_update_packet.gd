class_name HostPlayerUpdatePacket

var position: Vector3
var rotation: Vector3
var state_snapshot: Dictionary

func _init(p_position: Vector3, p_rotation: Vector3, p_state_snapshot: Dictionary):
	position = p_position
	rotation = p_rotation
	state_snapshot = p_state_snapshot

static func from_payload(payload: Dictionary) -> HostPlayerUpdatePacket:
	return HostPlayerUpdatePacket.new(
		PacketHelper.parse_vector(payload.get('pos')),
		PacketHelper.parse_vector(payload.get('rot')),
		payload.get('state')
	)

static func from_player(player: Player) -> Dictionary:
	return {
		'pos': PacketHelper.stringify_vector(player.body.global_position),
		'rot': PacketHelper.stringify_vector(player.body.rotation),
		'state': player.state_machine.get_snapshot()
	}
