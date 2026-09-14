extends PlayerControllerState

var _is_active: bool = false

func enter(_msg: Dictionary = {}) -> void:
	_is_active = true
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	controller.hud.show_text_box()

func exit() -> void:
	_is_active = false
	

func update(_delta: float) -> StateResult:
	if (Input.is_action_just_pressed("ui_accept")):
		return StateResult.transition_to(PlayerControllerState.IN_GAME)
		
	
	sync_camera_and_player()
	return StateResult.continue_result
