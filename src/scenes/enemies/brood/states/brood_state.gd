class_name BroodState
extends State

@onready var enemy: BroodEnemy  = $"../.." 

const GUARD: NodePath = ^"Guard"
const CHASE: NodePath = ^"Chase"
const ATTACK: NodePath = ^"Attack"
const HIT: NodePath = ^"Hit"
const DEATH: NodePath = ^"Death"

var enemy_got_hit_processor = EnemyGotHitProcessor.new(enemy)

	
