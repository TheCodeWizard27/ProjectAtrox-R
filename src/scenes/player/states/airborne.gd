extends PlayerState

func physics_update(delta: float) -> void:
	
	animator.advance_falling_to(1, delta)
	
	if(body.is_on_floor()):
		transition_to(PlayerState.GROUNDED)
		return
		
	player.process_movement(delta)
