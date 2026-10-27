class_name LobbyListEntry

var lobby_id: String
var name: String
var player_count: int

func _init(p_lobby_id: String, p_name: String, p_player_count: int):
	lobby_id = p_lobby_id
	name = p_name
	player_count = p_player_count
