extends LobbyControl
class_name SelectLobbyMenuControl

@onready var lobby_container = $MenuBackground/MarginContainer/VBoxContainer/MarginContainer/TempLobbyContainer

signal lobby_clicked(lobby: LobbyListEntry)
var _lobby_container_scene = preload('res://src/scenes/player/controller/lobby_menu/select_lobby/lobby_container.tscn')

func init_lobby_list(lobbies: Array[LobbyListEntry]) -> void:
	var all_children = lobby_container.get_children()
	for child: LobbyContainer in all_children:
		lobby_container.remove_child(child)
		child.clicked.disconnect(_on_lobby_clicked)
	
	for lobby in lobbies:
		var entry = _lobby_container_scene.instantiate() as LobbyContainer
		lobby_container.add_child(entry)
		entry.set_entry(lobby)
		entry.clicked.connect(_on_lobby_clicked.bind(lobby))

func _on_lobby_clicked(lobby: LobbyListEntry) -> void:
	lobby_clicked.emit(lobby)
