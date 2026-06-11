extends Node
class_name EntityManager

func _init() -> void:
	Events.spawn_entity.connect(_on_spawn_entity)
	
func _on_spawn_entity(entity: Entity, position: Vector3, rotation: Vector3) -> void:
	add_child(entity)
	entity.global_position = position
	entity.rotation = rotation
