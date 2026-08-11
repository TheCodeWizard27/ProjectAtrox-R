
class_name WarriorSpecialActionState
extends WarriorState

func physics_update(_delta: float) -> StateResult:
	
	if (player.status.resources.health <= 0):
		return StateResult.transition_to(PlayerState.DEAD)
	
	return StateResult.continue_result
