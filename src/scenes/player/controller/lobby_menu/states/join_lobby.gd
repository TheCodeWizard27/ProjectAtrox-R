extends LobbyState

@export var menu_control: SelectLobbyMenuControl

func _ready():
	init_for_control(menu_control)

func enter(msg: Dictionary = {}) -> void:
	super.enter(msg)
	
	menu_control.lobby_clicked.connect(_on_lobby_clicked)
	_load_lobbies()
	Events.networking.lobby_joined.connect(_on_lobby_joined)
	#Events.networking.lobby_join_failed.connect() TODO
	
func exit() -> void:
	super.exit()
	
	menu_control.lobby_clicked.disconnect(_on_lobby_clicked)
	Events.networking.lobby_joined.disconnect(_on_lobby_joined)
	#Events.networking.lobby_join_failed.disconnect() TODO

func _load_lobbies() -> void:
	var client = LobbyClient.new(NetworkConfiguration.get_current())
	add_child(client)
	
	var response = await client.get_lobbies()
	if (response.was_unsuccessful):
		# TODO Handle Error
		client.queue_free()
		return
	
	client.queue_free()
	menu_control.init_lobby_list(response.entries)

func _on_lobby_clicked(lobby: LobbyListEntry) -> void:
	# Step 1 Request address.
	var address = await get_address()
	if (address == null):
		# TODO Handle error
		return
	
	var client = LobbyClient.new(NetworkConfiguration.get_current())
	add_child(client)
	
	# Step 2 Request join lobby connection
	var join_response = await client.create_join_lobby_connection(CreateJoinLobbyConnectionRequest.new(
		lobby.lobby_id,
		'', # TODO Password
		address
	))
	if (join_response.was_unsuccessful):
		# TODO Handle Error
		client.queue_free()
		return
	
	# Step 3 Start WebSocket Connection
	var connection_response = client.connect_to_websocket(join_response.connection_id)
	if (connection_response.was_unsuccessful):
		# TODO Handle error
		client.queue_free()
		return
	
	client.queue_free()
	Events.networking.request_join_lobby(JoinLobbyData.new(
		lobby.name,
		connection_response.web_socket,
		address.ip,
		address.local_port
	))

func _on_lobby_joined() -> void:
	Events.scene_change_requested.emit(
		Locations.location_table.get(Locations.LocationEnum.HUB).path, {})
