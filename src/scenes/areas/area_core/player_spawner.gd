extends Marker3D
class_name PlayerSpawner

var _player_scene = preload('res://src/scenes/player/player.tscn')

func spawn(player_status: PlayerStatus) -> Player:
	var entity = _player_scene.instantiate() as Player
	entity.configure_player(player_status)
	Events.entity.spawn_entity(entity, global_position, rotation)
	return entity
