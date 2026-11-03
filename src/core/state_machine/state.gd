extends Node
class_name State

var is_synced: bool = false

func update(_delta: float) -> StateResult:
	return StateResult.continue_result

func physics_update(_delta: float) -> StateResult:
	return StateResult.continue_result

func get_snapshot() -> Dictionary:
	return {}

func sync(_snapshot: Dictionary) -> void:
	pass

func enter(_msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass
