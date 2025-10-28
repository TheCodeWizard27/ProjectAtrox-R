extends State
class_name WarriorState

var player: Player
var body: CharacterBody3D
var animator: PlayerAnimator
var controller: WarriorController

const AIRBORNE: NodePath = PlayerState.AIRBORNE
const GROUNDED: NodePath = PlayerState.GROUNDED
const JUMPING: NodePath = PlayerState.JUMPING
const ATTACKING: NodePath = PlayerState.ATTACKING

const WARRIOR_PRIMARY_ACTION: NodePath = ^'PrimaryAction'
const WARRIOR_SECONDARY_ACTION: NodePath = ^'SecondaryAction'
const WARRIOR_SPECIAL_ACTION: NodePath = ^'SpecialAction'
const WARRIOR_DEFENSIVE_ACTION: NodePath = ^'DefensiveAction'

func init(current_player: Player, current_controller: WarriorController) -> void:
	player = current_player
	animator = player.animator
	body = player.body
	controller = current_controller
