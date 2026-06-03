extends PlayerControllerState

var _is_active: bool = false

func enter(_msg: Dictionary = {}) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_is_active = true
	
	controller.ui_container.remove_child(controller.pause_menu)

func exit() -> void:
	_is_active = false
	
	controller.ui_container.add_child(controller.pause_menu)

func update(delta: float) -> void:
	if (Input.is_action_just_pressed("menu")):
		return transition_to(PlayerControllerState.IN_PAUSE_MENU)
	
	controller.hud.update(controller.target_player, delta)
	
	if (controller.target_player):
		# TODO Cleanup
		controller.target_player.target_detector.lock_on_ray.global_position = controller.camera_controller.global_position
		controller.target_player.target_detector.lock_on_ray.global_basis = controller.camera_controller.global_basis
		controller.camera_controller.lock_on_target = controller.target_player.lock_on_target
		controller.camera_controller.global_position = controller.target_player.camera_anchor.global_position
		controller.target_player.looking_direction = -controller.camera_controller.basis.z.normalized()

func _input(event: InputEvent) -> void:
	if (!_is_active):
		return
		
	if (event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
		var camera_speed = controller.camera_controller.camera_speed
		controller.camera_controller.process_camera_movement(event.relative * camera_speed)
	
	controller.camera_controller.push_event(event)
	
	if (controller.target_player):
		controller.target_player.push_event(event)
