class_name  BroodDeadState
extends BroodState

func enter(_msg: Dictionary = {}) -> void:
	enemy.hit_player.play('death')
	pass

func destroy() -> void:
	enemy.kill()
