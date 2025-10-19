extends BroodState

var _stuck_time: float

func enter(msg: Dictionary = {}) -> void:
	_stuck_time = enemy.attack_time
	enemy.attack()

func update(delta: float) -> void:
	_stuck_time -= delta
	
	if(_stuck_time <= 0):
		transition_to(BroodState.GUARD)
