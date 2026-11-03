class_name HostPacket

enum Event {
	UPDATE,
	AREA_CHANGED
}

static func create_packet(type: Event, payload: Dictionary) -> PackedByteArray:
	return PacketHelper.create_packet(type, payload)

static func is_type(packet: PackedByteArray, type: Event) -> bool:
	return PacketHelper.is_type(packet, type)

static func get_payload(packet: PackedByteArray) -> Dictionary:
	return PacketHelper.get_payload(packet)

static func get_type(packet: PackedByteArray) -> Event:
	return PacketHelper.get_type(packet) as Event
