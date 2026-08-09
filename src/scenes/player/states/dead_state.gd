class_name DeadState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	player.model_animator.play_death()

func physics_update(_delta: float) -> StateResult:
	
	return StateResult.continue_result
