extends Node3D

@onready var entities: Node = $Entities
@onready var start_position: Marker3D = $StartPosition

func _ready() -> void:
	spawn_player()

func spawn_player() -> void:
	var player_scene = preload('res://src/scenes/player/classes/warrior/warrior_class.tscn')
	var player = player_scene.instantiate() as Player
	player.global_position = start_position.global_position
	entities.add_child(player)
