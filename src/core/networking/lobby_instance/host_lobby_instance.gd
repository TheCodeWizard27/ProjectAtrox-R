class_name HostLobbyInstance
extends LobbyInstance

signal player_update(id: int, looking_direction: Vector3)
signal player_action(id: int, action: StringName, pressed: bool)
signal player_disconnected(id: int)

var _initialized_players: Dictionary[int, String] = {}
var _processor: HostLobbyProcessor

func _init(processor: HostLobbyProcessor):
	_processor = processor
	processor.packet_received.connect(_on_packet_received)
	processor.peer_connected.connect(_on_peer_connected)
	processor.peer_disconnected.connect(_on_peer_disconnected)
	processor.peer_disconnected.connect(player_disconnected.emit)

func stop() -> void:
	_processor.stop()

func send_update(players: Dictionary[int, Player], entities: Dictionary[int, Entity]) -> void:
	var player_part: Dictionary = {}
	var entity_part: Dictionary = {}
	var updates: Dictionary[String, Dictionary] = {
		'player': player_part,
		'entity': entity_part
	}
	
	for id in players:
		var player = players[id]
		player_part.set(id, HostPlayerUpdatePacket.from_player(player))
	
	for id in entities:
		var entity = entities[id]
		entity_part.set(id, HostEntityUpdatePacket.from_entity(entity))
	
	_processor.send_packet(HostPacket.Event.UPDATE, updates)

func send_area_changed(location: Locations.LocationEnum) -> void:
	_processor.send_packet(HostPacket.Event.AREA_CHANGED, {
		'area': location
	})

func get_unique_id() -> int:
	return _processor.get_peer_id()

func get_connected_players() -> Dictionary[int, String]:
	return _initialized_players.duplicate()

func _on_peer_connected(_id: int) -> void:
	pass

func _on_peer_disconnected(id: int) -> void:
	_initialized_players.erase(id)

func _on_packet_received(id: int, type: ClientPacket.Event, payload: Dictionary) -> void:
	match(type):
		ClientPacket.Event.INIT_PLAYER:
			_on_init_player(id, payload)
		ClientPacket.Event.ACTION_PRESSED:
			_on_player_action(id, payload, true)
		ClientPacket.Event.ACTION_RELEASED:
			_on_player_action(id, payload, false)
		ClientPacket.Event.UPDATE_LOOK_AT:
			_on_look_at_update(id, payload)

func _on_look_at_update(id: int, payload: Dictionary) -> void:
	player_update.emit(id, PacketHelper.parse_vector(payload.get('dir')))

func _on_player_action(id: int, payload: Dictionary, pressed: bool) -> void:
	player_action.emit(id, payload.get('action'), pressed)

func _on_init_player(id: int, payload: Dictionary) -> void:
	if (_initialized_players.has(id)):
		return
	
	var name = payload.get('name')
	_initialized_players.set(id, name)
	player_connected.emit(id, name)
