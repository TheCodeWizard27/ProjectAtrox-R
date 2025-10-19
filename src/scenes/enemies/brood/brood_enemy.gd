class_name BroodEnemy
extends BaseEnemy
	
func _process(delta: float) -> void:
	state.process(delta)
	
func move_towards_player(target: Player) -> void:
	if(is_near_player(target)):
		return

func is_near_player(target: Player) -> bool:
	var distance = body.global_position.distance_to(target._body.global_position)
	return distance <= attack_distance
	
func attack() -> void:
	pass
	
