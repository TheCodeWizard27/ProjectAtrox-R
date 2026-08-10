class_name DeadState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	player.model_animator.play_death()

func physics_update(_delta: float) -> StateResult:
	
	if (Input.is_key_pressed(KEY_1)):
		return StateResult.transition_to(PlayerState.GROUNDED)
	
	return StateResult.continue_result

func exit() -> void:
	player.model_animator.reset_death()
