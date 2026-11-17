extends LobbyControl
class_name CreateLobbyMenuControl

@onready var lobby_name_control: LineEdit = %LobbyNameEdit
@onready var password_control: LineEdit = %PasswordEdit
@onready var private_toggle_checkbox = %PrivateToggleCheckbox
@onready var password_container = %PasswordContainer
@onready var error_container = %PasswordValidationContainer

signal lobby_create_requested(create_data: CreateLobbyData)

func reset() -> void:
	error_container.hide()

func _on_create_lobby_button_pressed() -> void:
	error_container.hide()
	
	if (lobby_name_control.text.is_empty()):
		show_error_container()
		return
	
	var create_data: CreateLobbyData
	var password: String
	if(password_container.visible):
		if (password_control.text.is_empty()):
			show_error_container()
			return
		
		password = password_control.text
	create_data = CreateLobbyData.new(lobby_name_control.text, password)	
	lobby_create_requested.emit(create_data)

func show_error_container() -> void:
	error_container.show()

func private_checkbox_toggle() -> void:
	password_container.visible = private_toggle_checkbox.button_pressed
