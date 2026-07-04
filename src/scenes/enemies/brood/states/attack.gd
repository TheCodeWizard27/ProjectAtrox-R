extends BroodState

var _stuck_time: float

func enter(_msg: Dictionary = {}) -> void:
	_stuck_time = enemy.attack_time
	enemy.attack_box.monitoring = true

func exit() -> void:
	enemy.attack_box.monitoring = false

func update(delta: float) -> void:
	if (process_damage_taken()):
		return
	
	_stuck_time -= delta
	
	if(_stuck_time <= 0):
		transition_to(BroodState.GUARD)
