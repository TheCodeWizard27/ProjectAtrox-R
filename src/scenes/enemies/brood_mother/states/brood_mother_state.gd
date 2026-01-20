class_name BroodMotherState
extends State

@onready var enemy: BroodMotherEnemy = $"../.."

const GUARD: NodePath = ^"Buff"
const CHASE: NodePath = ^"Idle"
const ATTACK: NodePath = ^"Spawn"
