extends Node3D

@onready var player_spawn: Marker3D = $PlayerSpawn
@onready var entities: Node3D = $Entities

func _ready() -> void:
	var player = preload('res://src/scenes/player/player.tscn').instantiate() as Node3D
	entities.add_child(player)
	player.global_position = player_spawn.global_position
	$PlayerController.target_player = player
