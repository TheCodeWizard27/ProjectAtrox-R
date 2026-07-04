class_name EnemyGotHitProcessor

func process_hit(enemy: BaseEnemy) -> void:
	print("got hit, health remaining: ", enemy.current_health)
