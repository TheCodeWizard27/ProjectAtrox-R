extends Marker3D
class_name PlayerSpawner

var _player_scene = preload('res://src/scenes/player/player.tscn')

func spawn() -> Entity:
	var entity = _player_scene.instantiate() as Entity
	Events.spawn_entity.emit(entity, global_position, rotation)
	return entity
