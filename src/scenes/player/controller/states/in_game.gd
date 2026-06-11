extends PlayerControllerState

var _is_active: bool = false

var target_processor: TargetLockOnProcessor

func init(p_player_controller: PlayerController):
	super.init(p_player_controller)
	target_processor = TargetLockOnProcessor.new(p_player_controller)

func enter(_msg: Dictionary = {}) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_is_active = true
	
	controller.ui_container.remove_child(controller.pause_menu)

func exit() -> void:
	_is_active = false
	
	controller.ui_container.add_child(controller.pause_menu)

func update(delta: float) -> void:
	if (!controller.target_player):
		return
	
	if (Input.is_action_just_pressed("menu")):
		return transition_to(PlayerControllerState.IN_PAUSE_MENU)
	
	target_processor.process_lock_on()
	controller.hud.update(controller.target_player, delta)
	sync_camera_and_player()

func _input(event: InputEvent) -> void:
	if (!_is_active):
		return
	
	# Separately send mouse motion to camera_controller
	if (event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
		var camera_speed = controller.camera_controller.camera_speed
		controller.camera_controller.process_camera_movement(event.relative * camera_speed)
	
	target_processor.push_event(event)
	controller.camera_controller.push_event(event)
	
	if (controller.target_player):
		controller.target_player.push_event(event)
