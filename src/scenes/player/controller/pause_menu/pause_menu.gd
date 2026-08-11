extends Node3D
class_name PauseMenu

@onready var _pause_menu_control: PauseMenuControl = $InputRelay/SubViewport/PauseMenuControl

var _inventory_loaded = false

func subscribe_for_player(player: Player) -> void:
	player.inventory.inventory_updated.connect(on_inventory_updated)

func unsubscribe_for_player(player: Player) -> void:
	player.inventory.inventory_updated.disconnect(on_inventory_updated)

func update(player_status: PlayerStatus) -> void:
	_pause_menu_control.update(player_status)
	
	if not _inventory_loaded:
		_pause_menu_control.load_inventory(player_status)
		_pause_menu_control.load_gear(player_status)
		_inventory_loaded = true

func on_inventory_updated() -> void:
	_inventory_loaded = false

func get_entity_position() -> Vector3:
	return $RigidBody3D.position
	
func get_entity_rotation() -> Vector3:
	return $RigidBody3D.rotation
