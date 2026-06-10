extends Marker3D
class_name EntitySpawner

enum EnemyType {
	BROOD_MOTHER,
	BROOD
}

var _brood_scene = preload('res://src/scenes/enemies/brood/brood_enemy.tscn')
var _brood_mother_scene = preload('res://src/scenes/enemies/brood_mother/brood_mother_enemy.tscn')

@export var enemy_type: EnemyType

func spawn() -> Entity:
	match enemy_type:
		EnemyType.BROOD:
			return _spawn_scene(_brood_scene)
		EnemyType.BROOD_MOTHER:
			return _spawn_scene(_brood_mother_scene)
			
	return null

func _spawn_scene(resource: PackedScene) -> Entity:
	var entity = resource.instantiate() as Entity
	Events.spawn_entity.emit(entity, global_position, rotation)
	return entity
