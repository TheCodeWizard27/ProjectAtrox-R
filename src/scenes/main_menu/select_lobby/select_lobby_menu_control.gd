extends LobbyControl
class_name SelectLobbyMenuControl

@onready var lobby_container = $MenuBackground/MarginContainer/VBoxContainer/MarginContainer/TempLobbyContainer
@onready var no_lobbies_control = $MenuBackground/MarginContainer/VBoxContainer/MarginContainer/CardControlComponent
@onready var password_container = %PasswordContainer
@onready var password_input = %PasswordInputControl
@onready var password_validation_container = %PasswordValidationContainer

signal lobby_clicked(lobby: LobbyListEntry, password: String)
var _lobby_container_scene = preload('res://src/scenes/ui_components/card_control_component/card_control_component.tscn')
var selected_lobby = LobbyListEntry

func init_lobby_list(lobbies: Array[LobbyListEntry]) -> void:
	if (lobbies.size() > 0):
		no_lobbies_control.hide()
	else:
		no_lobbies_control.show()
	
	var all_children = lobby_container.get_children()
	for child: CardControlComponent in all_children:
		lobby_container.remove_child(child)
		child.clicked.disconnect(_on_lobby_clicked)
	
	for lobby in lobbies:
		var entry = _lobby_container_scene.instantiate() as CardControlComponent
		lobby_container.add_child(entry)
		entry.set_entry(lobby)
		entry.clicked.connect(_on_lobby_clicked.bind(lobby))

func _on_lobby_clicked(lobby: LobbyListEntry) -> void:
	if(lobby.is_private):
		password_container.visible = true
		selected_lobby = lobby
	else:
		lobby_clicked.emit(lobby)


func enter_password() -> void:
	lobby_clicked.emit(selected_lobby, password_input.text)

func show_password_error() -> void:
	password_validation_container.visible = true
	pass

func cancel_password_input() -> void:
	password_container.visible = false
	selected_lobby = null
	password_validation_container.visible = false
