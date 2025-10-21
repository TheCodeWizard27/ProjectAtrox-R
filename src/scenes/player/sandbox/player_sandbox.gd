extends Node3D

@onready var player: Player = $Player

func _ready() -> void:
	Events.camera_change_requested.emit(player.camera)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		$Player.set_target($Marker3D if not $Player.target else null)
