class_name HostLobbyInstance
extends LobbyInstance

signal player_update(id: int, looking_direction: Vector3)
signal player_action(id: int, action: StringName, pressed: bool)

var _initialized_players: Dictionary[int, String] = {}
var _processor: HostLobbyProcessor

func _init(processor: HostLobbyProcessor):
	_processor = processor
	processor.packet_received.connect(_on_packet_received)
	processor.peer_connected.connect(_on_peer_connected)
	processor.peer_disconnected.connect(_on_peer_disconnected)

func send_update(players: Dictionary[int, Player]) -> void:
	var updates: Dictionary[int, Dictionary] = {}
	
	for id in players:
		var player = players[id]
		updates.set(id, {
			'position': PacketHelper.stringify_vector(player.body.global_position)
		})
	
	_processor.send_packet(HostPacket.Event.UPDATE_PLAYERS, updates)

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
	
	player_connected.emit(id, payload.get('name'))
