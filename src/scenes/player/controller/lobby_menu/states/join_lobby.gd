extends LobbyState

@export var menu_control: SelectLobbyMenuControl

func _ready():
	init_for_control(menu_control)
