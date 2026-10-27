class_name LobbyClient
extends Node

const JSON_HEADER = 'Content-Type: application/json'
const RESPONSE_BODY = 3

var _configuration: NetworkConfiguration
var _https_url: String
var _ws_url: String
var _lobby_endpoint = '/Lobby'
var _get_lobbies_endpoint = _lobby_endpoint + '/Get'
var _create_host_lobby_connection_endpoint = _lobby_endpoint + '/CreateHostLobbyConnection'
var _create_join_lobby_connection_endpoint = _lobby_endpoint + '/CreateJoinLobbyConnection'
var _websocket_endpoint = _lobby_endpoint + '/ConnectToWebSocket'

func _init(p_configuration: NetworkConfiguration):
	_configuration = p_configuration
	_https_url = 'https://' + _configuration.hub_server
	_ws_url = 'wss://' + _configuration.hub_server

func connect_to_websocket(connection_id: String) -> LobbySocketConnectionResponse:
	var socket = WebSocketPeer.new()
	socket.heartbeat_interval = _configuration.web_socket_heartbeat_interval
	var url = _ws_url + _websocket_endpoint
	url += '?connectionId=' + connection_id
	var result = socket.connect_to_url(url)
	
	if (result != OK):
		return LobbySocketConnectionResponse.new_unsuccessful()
	
	return LobbySocketConnectionResponse.new(socket)

func get_lobbies() -> LobbyListResponse:
	var request = HTTPRequest.new()
	add_child(request)
	var result = request.request(_https_url + _get_lobbies_endpoint)
	
	if (result != OK):
		push_error(result)
		request.queue_free()
		return LobbyListResponse.new_unsuccessful()
	
	var response = await request.request_completed
	var body = response[RESPONSE_BODY]
	var raw_lobby_entries = JSON.parse_string(body.get_string_from_utf8()) as Array
	var lobby_entries: Array[LobbyListEntry] = []
	lobby_entries.assign(raw_lobby_entries.map(_map_to_lobby_list_entry))
	
	return LobbyListResponse.new(lobby_entries)

func create_host_lobby_connection(request_data: CreateHostLobbyConnectionRequest) -> LobbyConnectionResponse:
	var request = HTTPRequest.new()
	add_child(request)
	var data = JSON.stringify({
		'Name': request_data.name,
		'PublicIp': request_data.address_info.ip,
		'PublicPort': request_data.address_info.port,
		'LocalIp': request_data.address_info.local_ip,
		'LocalPort': request_data.address_info.local_port,
		'Password': request_data.password
	})
	var result = request.request(
		_https_url + _create_host_lobby_connection_endpoint,
		[JSON_HEADER],
		HTTPClient.METHOD_POST,
		data
	)
	
	if (result != OK):
		push_error(result)
		request.queue_free()
		return LobbyConnectionResponse.new_unsuccessful()
	
	var response = await request.request_completed
	var body = response[RESPONSE_BODY]
	var connection_id = JSON.parse_string(body.get_string_from_utf8())
	return LobbyConnectionResponse.new(connection_id)

func create_join_lobby_connection(request_data: CreateJoinLobbyConnectionRequest) -> LobbyConnectionResponse:
	var request = HTTPRequest.new()
	add_child(request)
	var data = JSON.stringify({
		'LobbyId': request_data.lobby_id,
		'PublicIp': request_data.address_info.ip,
		'PublicPort': request_data.address_info.port,
		'LocalIp': request_data.address_info.local_ip,
		'LocalPort': request_data.address_info.local_port,
		'Password': request_data.password
	})
	var result = request.request(
		_https_url + _create_join_lobby_connection_endpoint,
		[JSON_HEADER],
		HTTPClient.METHOD_POST,
		data
	)
	
	if (result != OK):
		push_error(result)
		request.queue_free()
		return LobbyConnectionResponse.new_unsuccessful()
	
	var response = await request.request_completed
	var body = response[RESPONSE_BODY]
	var connection_id = JSON.parse_string(body.get_string_from_utf8())
	return LobbyConnectionResponse.new(connection_id)

func _map_to_lobby_list_entry(entry: Dictionary) -> LobbyListEntry:
	return LobbyListEntry.new(
		entry['id'],
		entry['name'],
		entry['playerCount']
	)
