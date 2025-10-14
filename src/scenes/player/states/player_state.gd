class_name PlayerState
extends State

@onready var player: Player = $"../.."
@onready var body: CharacterBody3D = %Body
@onready var animator: PlayerAnimator = %PlayerAnimator

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'
const ATTACKING: NodePath = ^'Attacking'
