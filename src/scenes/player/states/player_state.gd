extends State
class_name PlayerState

var player: Player
var body: CharacterBody3D
var animator: PlayerAnimator

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'
const DEAD: NodePath = ^'Dead'

func init(current_player: Player) -> void:
	player = current_player
	body = player.body
	animator = player.animator
