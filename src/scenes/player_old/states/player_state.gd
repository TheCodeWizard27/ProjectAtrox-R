extends State
class_name OldPlayerState

var player: OldPlayer
var body: CharacterBody3D
var animator: OldPlayerAnimator

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'

func init(current_player: OldPlayer) -> void:
	player = current_player
	animator = player.animator
	body = player.body
