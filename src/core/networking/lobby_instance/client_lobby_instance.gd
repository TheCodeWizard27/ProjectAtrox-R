class_name ClientLobbyInstance
extends LobbyInstance

signal player_updated(id: int, position: HostPlayerUpdatePacket)
signal area_changed(location: Locations.LocationEnum)

var _initialized_players: Dictionary[int, String] = {}
var _processor: LobbyClientProcessor

func _init(processor: LobbyClientProcessor):
	_processor = processor
	processor.packet_received.connect(_on_packet_received)

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
		HostPacket.Event.UPDATE_PLAYERS:
			_on_update_players(id, payload)
		HostPacket.Event.AREA_CHANGED:
			_on_area_changed(id, payload)
	
func _on_update_players(_id: int, payload: Dictionary) -> void:
	var player_updates = payload as Dictionary[String, Dictionary]
	for raw_id in player_updates:
		var id = int(raw_id)
		var player = player_updates[raw_id]
		
		if (_processor.get_peer_id() != id && !_initialized_players.has(id)):
			_initialized_players.set(id, 'test')
			player_connected.emit(id, 'test')
		
		player_updated.emit(id, HostPlayerUpdatePacket.from_payload(player))

func _on_area_changed(_id: int, payload: Dictionary) -> void:
	area_changed.emit(payload.get('area') as Locations.LocationEnum)
