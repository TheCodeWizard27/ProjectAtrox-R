class_name InstanceManager
extends Node

const LOBBY_INSTANCE = 'instance'

@export var player_controller: PlayerController
@export var entity_manager: EntityManager
@export var player_spawner: PlayerSpawner

var lobby_instance: LobbyInstance
var players: Dictionary[int, Player] = {}

func init(instance: LobbyInstance) -> void:
	lobby_instance = instance
	
	if (instance is HostLobbyInstance):
		_init_for_host(instance)
	elif (instance is ClientLobbyInstance):
		_init_for_client(instance)
	
	lobby_instance.player_connected.connect(_on_player_connected)
	_init_existing_players()

func _init_existing_players() -> void:
	var connected_players = lobby_instance.get_connected_players()
	for id in connected_players:
		_on_player_connected(id, connected_players[id])

func _init_for_host(instance: HostLobbyInstance) -> void:
	instance.player_update.connect(_on_player_update)
	instance.player_action.connect(_on_player_action)
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.timeout.connect(_on_update_clients_tick.bind(instance))
	timer.start(1.0 / 30.0)

func _init_for_client(instance: ClientLobbyInstance) -> void:
	instance.player_updated.connect(_on_player_updated)
	player_controller.action_pressed.connect(instance.send_action)
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.timeout.connect(_on_update_server.bind(instance))
	timer.start(1.0 / 30.0)

func _on_update_clients_tick(instance: HostLobbyInstance) -> void:
	var player_updates: Dictionary[int, Player] = {
		1: player_controller.target_player
	}
	
	for peer_id in players:
		player_updates.set(peer_id, players[peer_id])
	
	instance.send_update(player_updates)

func _on_update_server(instance: ClientLobbyInstance) -> void:
	if (!player_controller.target_player):
		return
	
	instance.send_update(player_controller.target_player.looking_direction)

func _on_player_updated(id: int, position: Vector3) -> void:
	if (lobby_instance.get_unique_id() == id && player_controller.target_player):
		player_controller.target_player.body.global_position = position
		return
	
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.body.global_position = position

func _on_player_update(id: int, looking_direction: Vector3) -> void:
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.looking_direction = looking_direction

func _on_player_connected(id: int, _name: String) -> void:
	if (players.has(id)):
		return
	
	var player = player_spawner.spawn(PlayerStatus.new())
	players.set(id, player)
	print('Added player with id ', id)

func _on_player_action(id: int, action: StringName, pressed: bool) -> void:
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.set_action(action, pressed)
