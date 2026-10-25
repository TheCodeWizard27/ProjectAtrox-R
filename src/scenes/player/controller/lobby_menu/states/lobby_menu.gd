extends LobbyState

@export var menu_control: LobbyMenuControl

func _ready():
	init_for_control(menu_control)
