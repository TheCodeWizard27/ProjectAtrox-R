class_name LobbyConnectionResponse
extends LobbyClientResponse

var connection_id: String

func _init(p_connection_id: String):
	connection_id = p_connection_id

static func new_unsuccessful() -> LobbyConnectionResponse:
	var result = new('')
	result.was_unsuccessful = true
	return result
