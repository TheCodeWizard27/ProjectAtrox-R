extends CameraController

@onready var camera: Camera3D = $CameraArm/Camera3D

func _ready() -> void:
	active_changed.connect(func(value): camera.current = value)
