extends State
class_name PlayerControllerState

var controller: PlayerController

const IN_GAME: NodePath = ^'InGame'
const IN_PAUSE_MENU: NodePath = ^'InPauseMenu'

func init(p_player_controller: PlayerController) -> void:
	controller = p_player_controller
