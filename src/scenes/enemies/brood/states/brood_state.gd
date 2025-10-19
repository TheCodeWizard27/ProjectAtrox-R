class_name BroodState
extends State

@onready var enemy: BroodEnemy  = $"../.." 

const GUARD: NodePath = ^"Guard"
const CHASE: NodePath = ^"Chase"
const ATTACK: NodePath = ^"Attack"
