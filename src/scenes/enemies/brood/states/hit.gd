class_name BroodHitState
extends BroodState

func enter(_msg: Dictionary = {}) -> void:
	if (enemy.hit_player.is_animation_active()):
		enemy.hit_player.stop()
	enemy.hit_player.play('hit')
	enemy.current_health = enemy.current_health - 5

func physics_update(_delta: float) -> StateResult:
	if(enemy.current_health <= 0):
		return StateResult.transition_to(BroodState.DEAD)
		
	return StateResult.transition_to(BroodState.GUARD)

func exit() -> void:
	pass
