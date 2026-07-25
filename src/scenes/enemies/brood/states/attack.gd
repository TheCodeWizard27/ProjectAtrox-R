extends BroodState

var _stuck_time: float

func enter(_msg: Dictionary = {}) -> void:
	_stuck_time = enemy.attack_time
	enemy.attack_box.monitoring = true

func exit() -> void:
	enemy.attack_box.monitoring = false

func update(delta: float) -> StateResult:
	var result = process_damage_taken()
	if (result.type != StateResult.Type.CONTINUE):
		return result
	
	_stuck_time -= delta
	
	if(_stuck_time <= 0):
		return StateResult.transition_to(BroodState.GUARD)
	
	return StateResult.continue_result
