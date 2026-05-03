class_name CameraController
extends Node3D

@export_range(0, 1) var camera_speed: float = 0.2
@export var camera: Camera3D

var is_moving: bool = false
var lock_on_target: Node3D

func _ready():
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta: float) -> void:
	if (lock_on_target):
		_move_towards_target(delta)

	if (!camera or !camera.current):
		return

	var movement = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	process_camera_movement(movement * camera_speed * 2500 * delta)
	
func _move_towards_target(delta: float) -> void:
	var current_rotation = rotation
	var direction_to_target = global_position.direction_to(lock_on_target.global_position)
	var target_rotation = Basis.looking_at(direction_to_target).get_rotation_quaternion()
	
	basis = Basis(basis.get_rotation_quaternion().slerp(target_rotation, delta * 2))
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
		process_camera_movement(event.relative * camera_speed)

func process_camera_movement(movement: Vector2) -> void:
	is_moving = movement.length() > 0
	
	rotation_degrees.x = clamp(rotation_degrees.x - movement.y, -90, 30)
	rotation_degrees.y = wrapf(rotation_degrees.y - movement.x, 0, 360)
