
class_name MageState
extends State

var player: Player
var body: CharacterBody3D
var animator: PlayerAnimator
var controller: MageController

const AIRBORNE: NodePath = PlayerState.AIRBORNE
const GROUNDED: NodePath = PlayerState.GROUNDED
const JUMPING: NodePath = PlayerState.JUMPING

const MAGE_PRIMARY_ACTION: NodePath = ^'PrimaryAction'
const MAGE_SECONDARY_ACTION: NodePath = ^'SecondaryAction'
const MAGE_SPECIAL_ACTION: NodePath = ^'SpecialAction'
const MAGE_DEFENSIVE_ACTION: NodePath = ^'DefensiveAction'

func init(current_player: Player, current_controller: MageController) -> void:
	player = current_player
	animator = player.animator
	body = player.body
	controller = current_controller
