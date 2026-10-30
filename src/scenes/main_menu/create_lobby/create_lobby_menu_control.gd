extends LobbyControl
class_name CreateLobbyMenuControl

@onready var lobby_name_control = %LobbyNameEdit
@onready var password_control = %PasswordEdit

signal lobby_create_requested(create_data: CreateLobbyData)

func _on_create_lobby_button_pressed() -> void:
	var create_data = CreateLobbyData.new(lobby_name_control.text, password_control.text)
	lobby_create_requested.emit(create_data)
