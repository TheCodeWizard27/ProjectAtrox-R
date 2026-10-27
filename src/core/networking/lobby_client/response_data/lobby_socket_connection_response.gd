class_name LobbySocketConnectionResponse
extends LobbyClientResponse

var web_socket: WebSocketPeer

func _init(p_web_socket: WebSocketPeer):
	web_socket = p_web_socket

static func new_unsuccessful() -> LobbySocketConnectionResponse:
	var result = new(null)
	result.was_unsuccessful = true
	return result
