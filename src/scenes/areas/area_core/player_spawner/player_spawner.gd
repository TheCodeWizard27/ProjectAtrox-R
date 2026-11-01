extends Marker3D
class_name PlayerSpawner

var _spawner_slots: Array[Marker3D] = []

func get_next_spawn_location() -> Marker3D:
	if (_spawner_slots.size() <= 0):
		_init_slots()
	
	return _spawner_slots.pop_back()

func _init_slots() -> void:
	_spawner_slots = [
		$Slot1,
		$Slot2,
		$Slot3,
		$Slot4
	]
