extends PlayerControllerState

var _is_active: bool = false

func enter(_msg: Dictionary = {}) -> void:
	_is_active = true
	#controller.camera_controller.disable_camera_movement = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	controller.ui_container.remove_child(controller.hud)

func exit() -> void:
	_is_active = false
	#controller.camera_controller.disable_camera_movement = false
	
	controller.ui_container.add_child(controller.hud)

func update(_delta: float) -> void:
	if (Input.is_action_just_pressed("menu")):
		transition_to(PlayerControllerState.IN_GAME)

#func _input(event: InputEvent) -> void:
	#if (!_is_active):
		#return
	#
	#
