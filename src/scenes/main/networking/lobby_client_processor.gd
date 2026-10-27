class_name LobbyClientProcessor
extends Node

enum IncomingEventType {
	CONNECTION_INFO
}

var _web_socket: WebSocketPeer = WebSocketPeer.new()
var _enet_peer: ENetMultiplayerPeer
var _configuration: NetworkConfiguration
var _public_ip: String
var _local_port: int

var _started = false

func _ready() -> void:
	_configuration = NetworkConfiguration.get_current()
	Events.networking.join_lobby_requested.connect(_on_join_lobby_requested)

func _on_join_lobby_requested(join_data: JoinLobbyData) -> void:
	_web_socket = join_data.web_socket
	_public_ip = join_data.public_ip
	_local_port = join_data.port
	_started = true

func _process(_delta: float) -> void:
	if (!_started):
		return
	
	_web_socket.poll()
	
	var state = _web_socket.get_ready_state()
	
	if (state != WebSocketPeer.STATE_OPEN):
		return
	
	while _web_socket.get_available_packet_count():
		var packet = _web_socket.get_packet()
		if (_web_socket.was_string_packet()):
			_process_packet(packet)

func _process_packet(packet: PackedByteArray) -> void:
	var content = JSON.parse_string(packet.get_string_from_utf8())
	
	var type = content['Type']
	
	if (type != IncomingEventType.CONNECTION_INFO):
		return
	
	var ip = content['Data']['PublicIp']
	var port = content['Data']['PublicPort']
	var local_ip = content['Data']['LocalIp']
	var local_port = content['Data']['LocalPort']
	
	# If host and client are under the same address we should connect using the local ip.
	var target_ip = local_ip if ip == _public_ip else ip
	var target_port = local_port if ip == _public_ip else port
	
	_punch_hole(target_ip, target_port)
	
func _punch_hole(ip: String, port: int) -> void:
	var udp = PacketPeerUDP.new()
	udp.set_dest_address(ip, port)
	var udp_result = udp.bind(_local_port, '0.0.0.0')
	if (udp_result != OK):
		Events.networking.notify_lobby_join_failed()
		return
	
	var hole_punch_message = _configuration.hole_punch_message
	
	for i in range(_configuration.hole_punch_max_attempts):
		
		udp.put_packet(hole_punch_message.to_utf8_buffer())
		await get_tree().create_timer(_configuration.hole_punch_delay).timeout
		
		if (udp.get_available_packet_count() <= 0):
			continue
		
		var packet = udp.get_packet().get_string_from_utf8()
		if (!packet.begins_with(hole_punch_message)):
			continue
		
		_join_lobby(ip, port)
		# TODO Setup hole keep alive.
		return

func _join_lobby(ip: String, port: int) -> void:
	_enet_peer = ENetMultiplayerPeer.new()
	var result = _enet_peer.create_client(ip, port)
	if (result != OK):
		push_error('Couldnt join lobby: ', result)
		Events.networking.notify_lobby_join_failed()
		return
	
	multiplayer.multiplayer_peer = _enet_peer
	multiplayer.connected_to_server.connect(_on_connected)
	
func _on_connected() -> void:
	Events.networking.notify_lobby_joined()
