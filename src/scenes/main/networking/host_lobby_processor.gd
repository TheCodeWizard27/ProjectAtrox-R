class_name HostLobbyProcessor
extends Node

enum IncomingEventType {
	CONNECTION_INFO
}

var _web_socket: WebSocketPeer = WebSocketPeer.new()
var _enet_peer: ENetMultiplayerPeer
var _configuration: NetworkConfiguration
var _public_ip: String

var is_running = false

func _ready() -> void:
	_configuration = NetworkConfiguration.get_current()
	Events.networking.host_lobby_requested.connect(_on_host_server_requested)

func _on_host_server_requested(host_data: HostLobbyServerData) -> void:
	_web_socket = host_data.web_socket
	_public_ip = host_data.public_ip
	_start_hosting(host_data.port)

func _start_hosting(port: int) -> void:
	_enet_peer = ENetMultiplayerPeer.new()
	var result = _enet_peer.create_server(port, 4)
	if (result != OK):
		push_error('Couldnt start server: ', result)
		Events.networking.notify_lobby_server_start_failed()
		return
	
	multiplayer.multiplayer_peer = _enet_peer
	Events.networking.notify_lobby_server_started()
	print_debug('Started Server on ', port)
	is_running = true

func _process(_delta: float) -> void:
	if (not is_running):
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
	var connection = _enet_peer.host
	var hole_punch_message = _configuration.hole_punch_message
	
	for i in range(_configuration.hole_punch_max_attempts):
		connection.socket_send(ip, port, hole_punch_message.to_utf8_buffer())
		await get_tree().create_timer(_configuration.hole_punch_delay).timeout
		
		if (!_is_peer_connected(ip, port)):
			continue
		
		# TODO Setup hole keep alive.
		return
	
	# TODO handle failure
	
func _is_peer_connected(ip: String, port: int) -> bool:
	for peer_id in multiplayer.get_peers():
		var other_peer = _enet_peer.get_peer(peer_id)
		var peer_ip = other_peer.get_remote_address()
		var peer_port = other_peer.get_remote_port()
		
		if (ip == peer_ip and port == peer_port):
			return true
		
	return false
	
