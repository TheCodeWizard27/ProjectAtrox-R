class_name InstanceManager
extends Node

const LOBBY_INSTANCE = 'instance'

@export var player_controller: PlayerController
@export var entity_manager: EntityManager
@export var player_spawner: PlayerSpawner

var lobby_instance: LobbyInstance
var players: Dictionary[int, Player] = {}
var entities: Dictionary[int, Entity] = {}

func init(instance: LobbyInstance) -> void:
	lobby_instance = instance
	
	if (instance is HostLobbyInstance):
		_init_for_host(instance)
	elif (instance is ClientLobbyInstance):
		_init_for_client(instance)
	
	Events.entity.entity_spawn_requested.connect(_on_spawn_entity_request)
	Events.enemy.died.connect(_on_enemy_death)
	lobby_instance.player_connected.connect(_on_player_connected)
	
	var player = _spawn_player(PlayerStatus.new())
	player_controller.target_player = player
	_init_existing_players()

func _init_existing_players() -> void:
	var connected_players = lobby_instance.get_connected_players()
	for id in connected_players:
		_on_player_connected(id, connected_players[id])

func _init_for_host(instance: HostLobbyInstance) -> void:
	Events.area.area_change_requested.connect(_on_area_change_request)
	instance.player_update.connect(_on_player_update)
	instance.player_action.connect(_on_player_action)
	instance.player_disconnected.connect(_on_player_disconnected)
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.timeout.connect(_on_update_clients_tick.bind(instance))
	timer.start(1.0 / 30.0)

func _init_for_client(instance: ClientLobbyInstance) -> void:
	instance.disconnected.connect(_on_disconnected.bind(instance))
	
	if (!instance.is_connected_to_server()):
		_on_disconnected(instance)
	
	instance.player_updated.connect(_on_player_updated)
	instance.entity_updated.connect(_on_entity_updated)
	instance.area_changed.connect(_on_area_changed)
	player_controller.action_pressed.connect(instance.send_action)
	
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.timeout.connect(_on_update_server.bind(instance))
	timer.start(1.0 / 30.0)

func _on_area_changed(location: Locations.LocationEnum) -> void:
	#Events.area.request_area_change(location, {})
	_on_area_change_request(location, {})

func _on_update_clients_tick(instance: HostLobbyInstance) -> void:
	var player_updates: Dictionary[int, Player] = {
		1: player_controller.target_player
	}
	
	for peer_id in players.duplicate():
		player_updates.set(peer_id, players[peer_id])
	
	var entity_updates: Dictionary[int, Entity] = {}
	
	for entity_id in entities.duplicate():
		var entity = entities[entity_id]
		if (!is_instance_valid(entity)):
			entities.erase(entity_id)
			continue
		
		entity_updates.set(entity_id, entity)
	
	instance.send_update(player_updates, entity_updates)

func _on_update_server(instance: ClientLobbyInstance) -> void:
	if (!player_controller.target_player):
		return
	
	instance.send_update(player_controller.target_player.looking_direction)

func _on_player_updated(id: int, update: HostPlayerUpdatePacket) -> void:
	if (lobby_instance.get_unique_id() == id && player_controller.target_player):
		player_controller.target_player.body.global_position = update.position
		return
	
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.set_entity_rotation(update.rotation)
	player.set_entity_position(lerp(player.get_entity_position(), update.position, 0.8))
	player.sync_state(update.state_snapshot)

func _on_entity_updated(id: int, update: HostEntityUpdatePacket) -> void:
	if (!entities.has(id)):
		_spawn_entity(id, update)
	
	if (!is_instance_valid(entities.get(id))):
		entities.erase(id)
		return
	
	var entity = entities.get(id) as Entity
	
	entity.set_entity_position(lerp(entity.get_entity_position(), update.position, 0.8))
	entity.set_entity_rotation(update.rotation)
	entity.sync_state(update.state_snapshot)

func _on_player_update(id: int, looking_direction: Vector3) -> void:
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.looking_direction = looking_direction

func _on_player_connected(id: int, _name: String) -> void:
	if (players.has(id)):
		return
	
	var player = _spawn_player(PlayerStatus.new())
	players.set(id, player)

func _on_player_action(id: int, action: StringName, pressed: bool) -> void:
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.set_action(action, pressed)

func _on_enemy_death(entity: Enemy) -> void:
	if (lobby_instance is ClientLobbyInstance):
		return
	
	if (lobby_instance is HostLobbyInstance):
		entities.erase(entity.get_instance_id())
	
	entity_manager.spawn_item_entity(entity)

func _on_spawn_entity_request(entity: Entity, position: Vector3, rotation: Vector3) -> void:
	if (lobby_instance is ClientLobbyInstance):
		return
	
	if (lobby_instance is HostLobbyInstance):
		entities.set(entity.get_instance_id(), entity)
	
	entity_manager.spawn_entity(entity, position, rotation)

func _on_area_change_request(location: Locations.LocationEnum, data: Dictionary) -> void:
	if (lobby_instance is HostLobbyInstance):
		lobby_instance.send_area_changed(location)
	
	var area_scene_path = Locations.location_table.get(location).path
	data.set(InstanceManager.LOBBY_INSTANCE, lobby_instance)
	Events.request_scene_change(area_scene_path, data)

func _spawn_entity(id: int, packet: HostEntityUpdatePacket) -> void:
	var entity_path = EntityTable.get_entity_path(packet.entity_id)
	
	if (entity_path == null):
		return
	
	var entity = (load(entity_path) as PackedScene).instantiate() as Entity
	entity_manager.spawn_entity(entity, packet.position, packet.rotation)
	entities.set(id, entity)

func _spawn_player(player_status: PlayerStatus) -> Player:
	var spawn_location = player_spawner.get_next_spawn_location()
	return entity_manager.spawn_player(player_status,
		spawn_location.global_position, spawn_location.rotation)

func _on_player_disconnected(id: int) -> void:
	if (!players.has(id)):
		return
	
	var player = players.get(id) as Player
	player.queue_free()
	players.erase(id)

func _on_disconnected(instance: ClientLobbyInstance) -> void:
	instance.stop()
	var main_menu_path = Locations.location_table.get(Locations.LocationEnum.LOBBY_MENU).path
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Events.request_scene_change(main_menu_path, {})
