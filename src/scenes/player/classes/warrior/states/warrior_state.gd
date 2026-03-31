
class_name WarriorState
extends State

var player: WarriorClass
var body: CharacterBody3D
var model_animator: WarriorModelAnimator
var event_animator: AnimationPlayer

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

func init(current_player: WarriorClass) -> void:
	player = current_player
	model_animator = player.model_animator
	event_animator = player.event_animator
	body = player.body
