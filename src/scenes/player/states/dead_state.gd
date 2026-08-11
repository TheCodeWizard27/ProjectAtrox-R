class_name DeadState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	player.model_animator.play_death()

func physics_update(_delta: float) -> StateResult:
	
	player.status.current_health = 0
	
	if (Input.is_action_pressed('interact')):
		Events.scene_change_requested.emit(Locations.location_table.get(Locations.LocationEnum.HUB).path, {})
	
	return StateResult.continue_result

func exit() -> void:
	player.model_animator.reset_death()
