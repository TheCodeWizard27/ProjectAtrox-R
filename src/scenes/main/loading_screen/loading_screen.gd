extends Node3D
class_name LoadingScreen

@onready var camera: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play('load')

func update_progress(_progress: float) -> void:
	pass

func enable() -> void:
	Events.request_camera_change(camera)
	visible = true
	set_process(true)

func disable() -> void:
	visible = false
	set_process(false)
