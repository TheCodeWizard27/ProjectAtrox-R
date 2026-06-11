class_name Area
extends LoadableScene

@export var player_controller: PlayerController
@export var player_spawner: PlayerSpawner

func _ready() -> void:
	# Load if this scene was loaded without a loader
	if (self == get_tree().current_scene):
		onLoad({})

func onLoad(_data: Dictionary) -> void:
	# TODO Take data for player initialization
	var player = player_spawner.spawn(PlayerStatus.new())
	player_controller.target_player = player
