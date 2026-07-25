class_name EntityEvents

signal entity_spawn_requested(entity: Entity, position: Vector3, rotation: Vector3)
func spawn_entity(entity: Entity, position: Vector3, rotation: Vector3) -> void:
	entity_spawn_requested.emit(entity, position, rotation)
