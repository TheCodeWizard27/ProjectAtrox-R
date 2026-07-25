class_name EnemyEvents

signal died(entity: Enemy)
func notify_death(entity: Enemy) -> void:
	died.emit(entity)
