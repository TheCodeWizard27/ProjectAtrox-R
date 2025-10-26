extends Node3D

@onready var player: Player = $Player

func _ready() -> void:
	Events.camera_change_requested.emit(player.camera)
