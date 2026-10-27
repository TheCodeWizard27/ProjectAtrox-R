extends LobbyState

@export var menu_control: CreateLobbyMenuControl

func _ready():
	init_for_control(menu_control)
