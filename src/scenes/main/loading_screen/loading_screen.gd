extends Node3D
class_name LoadingScreen

@onready var camera: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_environment: AreaEnvironment = $AreaEnvironment

func _ready() -> void:
	remove_child(area_environment)
	animation_player.play('load')

func update_progress(_progress: float) -> void:
	pass

func enable() -> void:
	if (not has_node("AreaEnvironment")):
		add_child(area_environment)
	
	Events.request_camera_change(camera)
	visible = true
	set_process(true)

func disable() -> void:
	visible = false
	set_process(false)
	
	if (has_node("AreaEnvironment")):
		remove_child(area_environment)
