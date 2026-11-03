class_name LobbyInstance

var lobby_data: LobbyData

@warning_ignore("unused_signal")
signal player_connected(id: int, name: String)

func get_unique_id() -> int:
	return -1

func get_connected_players() -> Dictionary[int, String]:
	return {}
