extends LobbyState

@export var menu_control: ConfigureHubMenuControl

func _ready():
	init_for_control(menu_control)
