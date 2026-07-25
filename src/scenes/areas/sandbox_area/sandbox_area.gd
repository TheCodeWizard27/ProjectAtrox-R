extends Node3D

func _ready() -> void:
	Events.request_camera_change($Camera3D)
