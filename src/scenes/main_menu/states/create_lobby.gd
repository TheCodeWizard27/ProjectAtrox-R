extends LobbyState

@export var menu_control: CreateLobbyMenuControl

func _ready():
	init_for_control(menu_control)

func enter(msg: Dictionary = {}) -> void:
	super.enter(msg)
	
	menu_control.lobby_create_requested.connect(_on_lobby_create_requested)
	Events.networking.lobby_server_started.connect(_on_server_started)
	#Events.networking.lobby_server_start_failed.connect TODO
	
func exit() -> void:
	super.exit()
	
	menu_control.lobby_create_requested.disconnect(_on_lobby_create_requested)
	Events.networking.lobby_server_started.disconnect(_on_server_started)
	#Events.networking.lobby_server_start_failed.disconnect TODO

func _on_lobby_create_requested(data: CreateLobbyData) -> void:
	# Step 1 Request address.
	var address = await get_address()
	if (address == null):
		# TODO Handle error
		return
	
	# Step 2 Request create Lobby connection
	var client = LobbyClient.new(NetworkConfiguration.get_current())
	add_child(client)
	var create_response = await client.create_host_lobby_connection(CreateHostLobbyConnectionRequest.new(
		data.name,
		data.password,
		address
	))
	if (create_response.was_unsuccessful):
		# TODO Handle error
		client.queue_free()
		return
	
	# Step 3 Start WebSocket Connection
	var connection_response = client.connect_to_websocket(create_response.connection_id)
	if (connection_response.was_unsuccessful):
		# TODO Handle error
		client.queue_free()
		return
	
	client.queue_free()
	Events.networking.request_host_lobby(HostLobbyServerData.new(
		data.name,
		connection_response.web_socket,
		address.ip,
		address.local_port
	))

func _on_server_started() -> void:
	Events.scene_change_requested.emit(
		Locations.location_table.get(Locations.LocationEnum.HUB).path, {})
