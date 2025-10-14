extends Node3D

func _ready() -> void:
	Events.camera_change_requested.emit($Camera3D)
