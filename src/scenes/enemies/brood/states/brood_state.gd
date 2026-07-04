class_name BroodState
extends State

@onready var enemy: BroodEnemy  = $"../.." 

const GUARD: NodePath = ^"Guard"
const CHASE: NodePath = ^"Chase"
const ATTACK: NodePath = ^"Attack"
const HIT: NodePath = ^"Hit"
const DEAD: NodePath = ^"Dead"

var enemy_got_hit_processor = EnemyGotHitProcessor.new()

func process_damage_taken() -> bool:
	if(enemy.got_hit):
		enemy.got_hit = false
		enemy_got_hit_processor.process_hit(enemy)
		transition_to(BroodState.HIT)
		return true
	
	if(enemy.current_health <= 0): 
		transition_to(BroodState.DEAD) 
		return true
	
	return false
