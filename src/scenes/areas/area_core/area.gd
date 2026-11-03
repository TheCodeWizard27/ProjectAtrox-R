class_name Area
extends LoadableScene

@export var instance_manager: InstanceManager

func _ready() -> void:
	# Load if this scene was loaded without a loader
	if (self == get_tree().current_scene):
		on_load({})

func on_load(data: Dictionary) -> void:
	var instance = data.get(InstanceManager.LOBBY_INSTANCE) \
		if data.has(InstanceManager.LOBBY_INSTANCE) else OfflineLobbyInstance.new()
	
	instance_manager.init(instance)
