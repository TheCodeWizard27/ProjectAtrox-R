extends LobbyControl
class_name ConfigureHubMenuControl

@onready var host_address_input = %HostAddressInput

func save_changes() -> void:
	NetworkConfiguration.get_current().set_custom_hub_address(host_address_input.text)
