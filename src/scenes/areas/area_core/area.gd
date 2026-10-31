class_name Area
extends LoadableScene

@export var instance_manager: InstanceManager

func _ready() -> void:
	_init_area_events()
	
	# Load if this scene was loaded without a loader
	if (self == get_tree().current_scene):
		on_load({})

func on_load(data: Dictionary) -> void:
	var instance = data.get(InstanceManager.LOBBY_INSTANCE) \
		if data.has(InstanceManager.LOBBY_INSTANCE) else OfflineLobbyInstance.new()
	
	instance_manager.init(instance)
	var player = instance_manager.player_spawner.spawn(PlayerStatus.new())
	instance_manager.player_controller.target_player = player

func _init_area_events() -> void:
	Events.area.area_change_requested.connect(_on_area_change_request)

func _on_area_change_request(area_scene_path: String, data: Dictionary) -> void:
	data.set(InstanceManager.LOBBY_INSTANCE, instance_manager.lobby_instance)
	Events.request_scene_change(area_scene_path, data)
