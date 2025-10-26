extends PlayerState

func physics_update(delta: float) -> void:
	
	animator.advance_falling_to(0, delta)
	
	if(!body.is_on_floor()):
		transition_to(PlayerState.AIRBORNE)
		return
	
	if(Input.is_action_just_pressed("jump")):
		transition_to(PlayerState.JUMPING)
		return
	
	player.process_movement(delta)
	
	animator.set_running(Vector2(body.velocity.x, body.velocity.z).length())
