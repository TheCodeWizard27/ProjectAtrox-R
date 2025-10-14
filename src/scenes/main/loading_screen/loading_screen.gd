extends Node3D
class_name LoadingScreen

@onready var camera: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play('load')

func update_progress(progress: float) -> void:
	pass

func enable() -> void:
	Events.camera_change_requested.emit(camera)
	visible = true
	set_process(true)

func disable() -> void:
	visible = false
	set_process(false)
