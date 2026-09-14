extends PlayerControllerState

var _is_active: bool = false

func enter(_msg: Dictionary = {}) -> void:
	_is_active = true
	#controller.camera_controller.disable_camera_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	controller.ui_container.remove_child(controller.hud)
	controller.ui_container.add_child(controller.pause_menu)

func exit() -> void:
	_is_active = false
	#controller.camera_controller.disable_camera_movement = false
	
	controller.ui_container.add_child(controller.hud)
	controller.ui_container.remove_child(controller.pause_menu)

func update(delta: float) -> StateResult:
	if (Input.is_action_just_pressed("menu")):
		return StateResult.transition_to(PlayerControllerState.IN_GAME)
		
	if (controller.target_player):
		controller.pause_menu.update(controller.target_player.status)
	
	controller.hud.update(controller.target_player, delta)
	sync_camera_and_player()
	return StateResult.continue_result
