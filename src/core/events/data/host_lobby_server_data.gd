class_name HostLobbyServerData

var lobby_name: String
var public_ip: String
var web_socket: WebSocketPeer
var port: int

func _init(p_name: String, p_web_socket: WebSocketPeer, p_public_ip: String, p_port: int):
	lobby_name = p_name
	public_ip = p_public_ip
	web_socket = p_web_socket
	port = p_port
