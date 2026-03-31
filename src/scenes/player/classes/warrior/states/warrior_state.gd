
class_name WarriorState
extends State

var player: WarriorClass
var body: CharacterBody3D
var animator: PlayerAnimator

const AIRBORNE: NodePath = PlayerState.AIRBORNE
const GROUNDED: NodePath = PlayerState.GROUNDED
const JUMPING: NodePath = PlayerState.JUMPING

const WARRIOR_AIRBORNE: NodePath = ^'Airborne'
const WARRIOR_GROUNDED: NodePath = ^'Grounded'
const WARRIOR_JUMPING: NodePath = ^'Jumping'
const WARRIOR_DEAD: NodePath = ^'Dead'
const WARRIOR_PRIMARY_ACTION: NodePath = ^'PrimaryAction'
const WARRIOR_SECONDARY_ACTION: NodePath = ^'SecondaryAction'
const WARRIOR_SPECIAL_ACTION: NodePath = ^'SpecialAction'
const WARRIOR_DEFENSIVE_ACTION: NodePath = ^'DefensiveAction'

func init(current_player: Player) -> void:
	player = current_player
	animator = player.animator
	body = player.body
