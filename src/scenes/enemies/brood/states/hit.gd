class_name BroodHitState
extends BroodState

func enter(_msg: Dictionary = {}) -> void:
	enemy.hit_player.play('hit')
	enemy.current_health = enemy.current_health - 5
	if(enemy.current_health <= 0):
		return transition_to(BroodState.DEAD)
		
	return transition_to(BroodState.GUARD)

func exit() -> void:
	pass
