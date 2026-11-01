extends Marker3D
class_name PlayerSpawner

var _spawner_slots: Array[Marker3D] = []

var _player_scene = preload('res://src/scenes/player/player.tscn')

func spawn(player_status: PlayerStatus) -> Player:
	if (_spawner_slots.size() <= 0):
		_init_slots()
	
	var current_slot = _spawner_slots.pop_back()
	
	var entity = _player_scene.instantiate() as Player
	entity.configure_player(player_status)
	Events.entity.spawn_entity(entity, current_slot.global_position, current_slot.rotation)
	return entity

func _init_slots() -> void:
	_spawner_slots = [
		$Slot1,
		$Slot2,
		$Slot3,
		$Slot4
	]
