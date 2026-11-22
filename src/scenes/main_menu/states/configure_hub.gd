extends LobbyState

@export var menu_control: ConfigureHubMenuControl

func _ready():
	init_for_control(menu_control)

func enter(msg: Dictionary = {}) -> void:
	super(msg)
	menu_control.host_address_input.text = NetworkConfiguration.get_current().hub_server
