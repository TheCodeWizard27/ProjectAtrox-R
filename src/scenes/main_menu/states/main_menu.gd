extends LobbyState

@export var menu_control: MainMenuControl

func _ready():
	init_for_control(menu_control)
