class_name LobbyListEntry

var lobby_id: String
var name: String
var player_count: int
var is_private: bool

func _init(p_lobby_id: String, p_name: String, p_player_count: int, p_is_private: bool):
	lobby_id = p_lobby_id
	name = p_name
	player_count = p_player_count
	is_private = p_is_private
