class_name EnemyGotHitProcessor

var enemy: BroodEnemy

func _init(broodEnemy: BroodEnemy) -> void:
	self.enemy	= broodEnemy
	
func process_hit() -> void:
	print("got hit")
