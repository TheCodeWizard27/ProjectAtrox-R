extends Node3D
class_name PauseMenu

@onready var _pause_menu_control: PauseMenuControl = $InputRelay/SubViewport/PauseMenuControl

var _inventory_loaded = false

func update(player_status: PlayerStatus) -> void:
	_pause_menu_control.update(player_status)
	
	if not _inventory_loaded:
		_pause_menu_control.load_inventory(player_status)
		_pause_menu_control.load_gear(player_status)
		_inventory_loaded = true
