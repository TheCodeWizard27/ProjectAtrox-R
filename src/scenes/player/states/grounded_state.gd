class_name GroundedState
extends PlayerState

var movement_processor: PlayerMovementProcessor

func init(current_player: Player) -> void:
	super.init(current_player)
	movement_processor = PlayerMovementProcessor.new(current_player)

func physics_update(delta: float) -> void:
	
	model_animator.advance_falling_to(0, delta)
	
	if (!body.is_on_floor()):
		return transition_to(PlayerState.AIRBORNE)
	
	if (player.input_buffer.is_action_just_pressed("jump")):
		return transition_to(PlayerState.JUMPING)
	
	if (player.input_buffer.is_action_just_pressed("defensive_action") and player.defensive_action_state):
		return transition_to(player.defensive_action_state)
	
	if (player.input_buffer.is_action_just_pressed("primary_action") and player.primary_action_state):
		return transition_to(player.primary_action_state)
	
	if (player.input_buffer.is_action_just_pressed("secondary_action") and player.secondary_action_state):
		return transition_to(player.secondary_action_state)
	
	if (player.input_buffer.is_action_just_pressed("special_action") and player.special_action_state):
		return transition_to(player.special_action_state)
		
	if(player.target_detector.interaction_target != null and Input.is_action_just_pressed("interact")):
		player.target_detector.interaction_target.interact()
	
	movement_processor.process_movement(delta)
	
	model_animator.set_running(Vector2(body.velocity.x, body.velocity.z).length())
