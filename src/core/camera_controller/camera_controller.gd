class_name CameraController
extends Node3D

@export_range(0, 1) var camera_speed: float = 0.2
@export var camera: Camera3D

var disable_camera_movement: bool

var is_moving: bool = false
var lock_on_target: Node3D
var input_buffer: InputBuffer = InputBuffer.new()

func push_event(event: InputEvent) -> void:
	input_buffer.push_event(event)

func _process(delta: float) -> void:
	if (lock_on_target):
		_move_towards_target(delta)
	
	if (!camera or !camera.current):
		return

	var movement = input_buffer.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	process_camera_movement(movement * camera_speed * 2500 * delta)
	
	input_buffer.clear()
	
func _move_towards_target(delta: float) -> void:
	var current_rotation = rotation
	var direction_to_target = global_position.direction_to(lock_on_target.global_position)
	var target_rotation = Basis.looking_at(direction_to_target).get_rotation_quaternion()
	
	basis = Basis(basis.get_rotation_quaternion().slerp(target_rotation, delta * 2))
	rotation.x = current_rotation.x
	rotation.z = current_rotation.z

func process_camera_movement(movement: Vector2) -> void:
	is_moving = movement.length() > 0
	
	rotation_degrees.x = clamp(rotation_degrees.x - movement.y, -89, 30)
	rotation_degrees.y = wrapf(rotation_degrees.y - movement.x, 0, 360)
