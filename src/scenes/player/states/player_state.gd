extends State
class_name PlayerState

var player: Player
var body: CharacterBody3D
var model_animator: PlayerModelAnimator
var event_player: PlayerEventPlayer

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
const JUMPING: NodePath = ^'Jumping'
const DEAD: NodePath = ^'Dead'

func init(current_player: Player) -> void:
	player = current_player
	body = player.body
	model_animator = player.model_animator
	event_player = player.event_player
