class_name Entity
extends Node3D

func get_entity_id() -> EntityIds.Id:
	return EntityIds.Id.UNKNOWN

func get_hit() -> void:
	pass

func get_state_snapshot() -> Dictionary:
	return {}

func sync_state(_snapshot: Dictionary) -> void:
	pass

func get_entity_position() -> Vector3:
	return position
	
func get_entity_rotation() -> Vector3:
	return rotation

func set_entity_rotation(_rotation: Vector3) -> void:
	pass

func set_entity_position(_position: Vector3) -> void:
	pass

func add_effect(_effect_reference: EffectReference) -> void:
	pass
