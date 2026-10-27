class_name LobbyListResponse
extends LobbyClientResponse

var entries: Array[LobbyListEntry]

func _init(p_entries: Array[LobbyListEntry]):
	entries = p_entries

static func new_unsuccessful() -> LobbyListResponse:
	var result = new([])
	result.was_unsuccessful = true
	return result
