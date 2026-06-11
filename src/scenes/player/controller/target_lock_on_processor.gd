class_name TargetLockOnProcessor

var input_buffer: InputBuffer = InputBuffer.new()
var player_controller: PlayerController
var camera_controller: CameraController

func _init(p_player_controller: PlayerController):
	player_controller = p_player_controller
	camera_controller = player_controller.camera_controller

func process_lock_on() -> void:	
	if (input_buffer.is_action_just_pressed("toggle_lock_on")):
		_toggle_lock_on()
	elif (camera_controller.lock_on_target and _is_camera_moving()):
		var new_target = player_controller.lock_on_target_detector.find_lock_on_target()
		camera_controller.lock_on_target = new_target if new_target != null else camera_controller.lock_on_target
		
	input_buffer.update()

func push_event(event: InputEvent) -> void:
	input_buffer.push_event(event)

func _is_camera_moving() -> bool:
	var movement = input_buffer.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	var mouse_movement = Input.get_last_mouse_velocity()
	return movement.length() > 0 or mouse_movement.length() > 0

func _toggle_lock_on() -> void:
	if (camera_controller.lock_on_target):
		camera_controller.lock_on_target = null
		return
	
	camera_controller.lock_on_target = player_controller.lock_on_target_detector.find_lock_on_target()
