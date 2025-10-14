extends Node3D
class_name LoadingScreen

@export var _camera: Camera3D

func init():
	Events.camera_change_requested.emit(_camera)
