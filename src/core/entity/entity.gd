class_name Entity
extends Node3D

func get_hit() -> void:
	pass

func get_entity_position() -> Vector3:
	return position
	
func get_entity_rotation() -> Vector3:
	return rotation

func set_entity_rotation(_rotation: Vector3) -> void:
	pass

func add_effect(_effect_reference: EffectReference) -> void:
	pass
