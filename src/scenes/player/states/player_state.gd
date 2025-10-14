class_name PlayerState
extends State

@export var player: Player
@export var body: CharacterBody3D
@export var animator: PlayerAnimator

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'
const ATTACKING: NodePath = ^'Attacking'
