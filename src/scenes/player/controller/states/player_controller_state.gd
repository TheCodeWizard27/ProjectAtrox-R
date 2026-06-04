extends State
class_name PlayerControllerState

var controller: PlayerController

const IN_GAME: NodePath = ^'InGame'
const IN_PAUSE_MENU: NodePath = ^'InPauseMenu'

func init(p_player_controller: PlayerController) -> void:
	controller = p_player_controller

func sync_camera_and_player() -> void:
	if (!controller.target_player):
		return
	
	var player = controller.target_player
	var camera_controller = controller.camera_controller
	
	player.lock_on_target = camera_controller.lock_on_target
	player.looking_direction = -camera_controller.basis.z.normalized()
	camera_controller.global_position = player.camera_anchor.global_position
