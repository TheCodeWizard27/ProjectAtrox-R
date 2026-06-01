class_name EnemyGotHitProcessor

	
func process_hit(enemy: BaseEnemy) -> void:
	enemy.current_health = enemy.current_health -5
	print("got hit, health remaining: ", enemy.current_health)
