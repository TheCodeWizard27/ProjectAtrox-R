class_name EntitySpawner
extends Marker3D

func spawn() -> Entity:
	return null

func _spawn_scene(resource: PackedScene) -> Entity:
	var entity = resource.instantiate() as Entity
	Events.entity.spawn_entity(entity, global_position, rotation)
	return entity
