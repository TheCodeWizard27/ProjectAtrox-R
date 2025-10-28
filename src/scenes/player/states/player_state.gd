extends State
class_name PlayerState

var player: Player
var body: CharacterBody3D
var animator: PlayerAnimator

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'

func init(current_player: Player) -> void:
	player = current_player
	animator = player.animator
	body = player.body
