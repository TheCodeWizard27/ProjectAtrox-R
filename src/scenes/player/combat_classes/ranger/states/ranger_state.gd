extends State
class_name RangerState

var player: Player
var body: CharacterBody3D
var animator: PlayerAnimator
var controller: RangerController

const AIRBORNE: NodePath = PlayerState.AIRBORNE
const GROUNDED: NodePath = PlayerState.GROUNDED
const JUMPING: NodePath = PlayerState.JUMPING
const ATTACKING: NodePath = PlayerState.ATTACKING

const RANGER_PRIMARY_ACTION: NodePath = ^'PrimaryAction'
const RANGER_SECONDARY_ACTION: NodePath = ^'SecondaryAction'
const RANGER_SPECIAL_ACTION: NodePath = ^'SpecialAction'
const RANGER_DEFENSIVE_ACTION: NodePath = ^'DefensiveAction'

func init(current_player: Player, current_controller: RangerController) -> void:
	player = current_player
	animator = player.animator
	body = player.body
	controller = current_controller
