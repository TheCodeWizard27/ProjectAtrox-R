class_name CameraController
extends Node3D

@export_range(0, 1) var mouse_sensitivity: float = 0.2
@export var camera: Camera3D

var target: Node3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if (target):
		_move_towards_target(delta)

func _move_towards_target(delta: float) -> void:
	var current_rotation = rotation
	var direction_to_target = global_position.direction_to(target.global_position)
	var target_rotation = Basis.looking_at(direction_to_target)

	basis = basis.slerp(target_rotation, delta * 2)
	rotation.x = current_rotation.x
	rotation.z = current_rotation.z

func _input(event: InputEvent) -> void:
	if (!camera or !camera.current):
		return
	
	if (event.is_action("click")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if (event.is_action_pressed("toggle_mouse_captured")):
		if (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if (event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = lerpf(rotation_degrees.x, clamp(rotation_degrees.x, -90, 30), 1)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = lerpf(rotation_degrees.y, wrapf(rotation_degrees.y, 0, 360), 1)
