extends LobbyControl
class_name CreateLobbyMenuControl

@onready var lobby_name_control = %LobbyNameEdit
@onready var password_control = %PasswordEdit
@onready var private_toggle_checkbox = %PrivateToggleCheckbox
@onready var password_container = %PasswordContainer

signal lobby_create_requested(create_data: CreateLobbyData)

func _on_create_lobby_button_pressed() -> void:
	var create_data: CreateLobbyData
	var password: String
	if(private_toggle_checkbox.pressed):
		password = password_control.text
	create_data = CreateLobbyData.new(lobby_name_control.text, password)	
	lobby_create_requested.emit(create_data)


func private_checkbox_toggle() -> void:
	password_container.visible = private_toggle_checkbox.button_pressed
	pass # Replace with function body.
