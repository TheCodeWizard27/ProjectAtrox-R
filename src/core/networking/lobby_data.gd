class_name LobbyData

var name: String

var players: Dictionary[int, String] = {}

func _init(p_name: String):
	name = p_name
