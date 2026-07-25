extends Node
class_name State

func update(_delta: float) -> StateResult:
	return StateResult.continue_result

func physics_update(_delta: float) -> StateResult:
	return StateResult.continue_result

func enter(_msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass
