extends Node
class_name CameraManager

var _current_camera: Camera3D

func _ready() -> void:
	_current_camera = get_viewport().get_camera_3d()
	Events.camera_change_requested.connect(_change_camera)

func _change_camera(camera: Camera3D) -> void:
	if _current_camera:
		_current_camera.clear_current()

	camera.make_current()
