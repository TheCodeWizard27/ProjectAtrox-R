extends Node3D

@onready var entities: Node = $Entities
@onready var start_position: Marker3D = $StartPosition
@onready var player_controller: PlayerController = $PlayerController

func _ready() -> void:
	spawn_player()

func spawn_player() -> void:
	var player_scene = preload('res://src/scenes/player/player.tscn')
	var player = player_scene.instantiate() as Player
	entities.add_child(player)
	player.global_position = start_position.global_position
	player_controller.target_player = player
