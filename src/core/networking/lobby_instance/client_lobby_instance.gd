class_name ClientLobbyInstance
extends LobbyInstance

signal disconnected()
signal player_updated(id: int, player: HostPlayerUpdatePacket)
signal player_disconnected(id: int)
signal entity_updated(id: int, entity: HostEntityUpdatePacket)
signal area_changed(location: Locations.LocationEnum)

var _initialized_players: Dictionary[int, String] = {}
var _processor: LobbyClientProcessor

func _init(processor: LobbyClientProcessor):
	_processor = processor
	processor.packet_received.connect(_on_packet_received)
	processor.disconnected.connect(disconnected.emit)

func stop() -> void:
	_processor.stop()

func is_connected_to_server() -> bool:
	return _processor.is_connected_to_server()

func send_action(action: StringName, is_pressed: bool) -> void:
	var event = ClientPacket.Event.ACTION_PRESSED \
		if is_pressed else ClientPacket.Event.ACTION_RELEASED
		
	_processor.send_packet(event, {
		'action': action
	})

func send_update(looking_direction: Vector3) -> void:
	_processor.send_packet(ClientPacket.Event.UPDATE_LOOK_AT, {
		'dir': PacketHelper.stringify_vector(looking_direction)
	})

func get_unique_id() -> int:
	return _processor.get_peer_id()

func get_connected_players() -> Dictionary[int, String]:
	return _initialized_players.duplicate()

func _on_packet_received(id: int, type: HostPacket.Event, payload: Dictionary) -> void:
	match(type):
		HostPacket.Event.UPDATE:
			_on_update(id, payload)
		HostPacket.Event.AREA_CHANGED:
			_on_area_changed(id, payload)
	
func _on_update(_id: int, payload: Dictionary) -> void:
	var player_updates = payload.get('player') as Dictionary[String, Dictionary]
	for raw_id in player_updates:
		var id = int(raw_id)
		var player = player_updates[raw_id]
		
		if (_processor.get_peer_id() != id && !_initialized_players.has(id)):
			_initialized_players.set(id, 'test')
			player_connected.emit(id, 'test')
		
		player_updated.emit(id, HostPlayerUpdatePacket.from_payload(player))
	
	for id in _initialized_players:
		var player_exists = player_updates.has(str(id))
		
		if (not player_exists):
			player_disconnected.emit(id)
	
	var entity_updates = payload.get('entity') as Dictionary[String, Dictionary]
	for raw_id in entity_updates:
		var id = int(raw_id)
		var entity = entity_updates[raw_id]
		entity_updated.emit(id, HostEntityUpdatePacket.from_payload(entity))

func _on_area_changed(_id: int, payload: Dictionary) -> void:
	area_changed.emit(payload.get('area') as Locations.LocationEnum)
