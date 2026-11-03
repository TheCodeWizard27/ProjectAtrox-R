class_name HostEntityUpdatePacket

var entity_id: EntityIds.Id
var position: Vector3
var rotation: Vector3
var state_snapshot: Dictionary

func _init(p_id: EntityIds.Id, p_position: Vector3, p_rotation: Vector3, p_state_snapshot: Dictionary):
	entity_id = p_id
	position = p_position
	rotation = p_rotation
	state_snapshot = p_state_snapshot

static func from_payload(payload: Dictionary) -> HostEntityUpdatePacket:
	return HostEntityUpdatePacket.new(
		payload.get('id'),
		PacketHelper.parse_vector(payload.get('pos')),
		PacketHelper.parse_vector(payload.get('rot')),
		payload.get('state')
	)

static func from_entity(entity: Entity) -> Dictionary:
	return {
		'id': entity.get_entity_id(),
		'pos': PacketHelper.stringify_vector(entity.get_entity_position()),
		'rot': PacketHelper.stringify_vector(entity.get_entity_rotation()),
		'state': entity.get_state_snapshot()
	}
