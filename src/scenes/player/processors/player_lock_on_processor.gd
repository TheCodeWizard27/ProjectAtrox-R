class_name PlayerLockOnProcessor

var player: Player
var camera: Camera3D
var target_detector: TargetDetector

func _init(current_player: Player):
	self.player = current_player
	self.target_detector = current_player.target_detector

func process_lock_on() -> void:	
	if (player.input_buffer.is_action_just_pressed("toggle_lock_on")):
		_toggle_lock_on()
	elif (player.lock_on_target and _is_camera_moving()):
		var new_target = target_detector.find_lock_on_target()
		player.lock_on_target = new_target if new_target != null else player.lock_on_target

func _is_camera_moving() -> bool:
	var movement = player.input_buffer.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	var mouse_movement = Input.get_last_mouse_velocity()
	return movement.length() > 0 or mouse_movement.length() > 0

func _toggle_lock_on() -> void:
	if (player.lock_on_target):
		player.lock_on_target = null
		return
	
	player.lock_on_target = target_detector.find_lock_on_target()
