extends Node
class_name State

signal transitioned_to(target_state_path: NodePath, msg: Dictionary)
signal transitioned_back(msg: Dictionary)

func transition_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	transitioned_to.emit(target_state_path, msg)

func transition_back(msg: Dictionary = {}) -> void: 
	transitioned_back.emit(msg)

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass
