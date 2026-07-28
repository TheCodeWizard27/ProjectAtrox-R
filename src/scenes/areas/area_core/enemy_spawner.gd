class_name EnemySpawner
extends EntitySpawner

enum EntityType {
	BROOD_MOTHER,
	BROOD
}

var _brood_scene = preload('res://src/scenes/enemies/brood/brood_enemy.tscn')
var _brood_mother_scene = preload('res://src/scenes/enemies/brood_mother/brood_mother_enemy.tscn')

@export var enemy_type: EntityType

func spawn() -> Entity:
	match enemy_type:
		EntityType.BROOD:
			return _spawn_scene(_brood_scene)
		EntityType.BROOD_MOTHER:
			return _spawn_scene(_brood_mother_scene)
			
	return null
