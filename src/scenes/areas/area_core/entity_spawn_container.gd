extends Node3D
class_name EntitySpawnContainer

var _spawned_entities: Array[Entity] = []

signal all_entities_dead()

func spawn() -> void:
	for node in get_children():
		if (node is EntitySpawner):
			var entity = node.spawn()
			_spawned_entities.push_back(entity)
			entity.tree_exited.connect(_on_entity_death)

func _any_entity_alive() -> bool:
	return _spawned_entities.any(func(entity): return is_instance_valid(entity) and !entity.is_queued_for_deletion())
			
func _on_entity_death() -> void:
	if(!_any_entity_alive()):
		all_entities_dead.emit()
