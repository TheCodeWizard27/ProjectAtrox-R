extends Node3D
class_name PauseMenu

@onready var _pause_menu_control: PauseMenuControl = $InputRelay/SubViewport/PauseMenuControl

func update(player_status: PlayerStatus) -> void:
	_pause_menu_control.update(player_status)
