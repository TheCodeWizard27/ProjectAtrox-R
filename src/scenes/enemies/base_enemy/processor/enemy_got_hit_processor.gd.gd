class_name EnemyGotHitProcessor

func process_hit(enemy: Enemy) -> void:
	print("got hit, health remaining: ", enemy.current_health)
