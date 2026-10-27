extends Node3D
class_name LobbyMenuView

@export var state_machine: StateMachine

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:	
	state_machine.physics_process(delta)

func change_lobby_menu_screen(menuEnum: Enums.LobbyMenuScreens) -> void:
	if(menuEnum != Enums.LobbyMenuScreens.PLAY_OFFLINE):
		state_machine.current_state.set_transition_result(menuEnum)
	else: 
		start_offline_mode()
	

func start_offline_mode() -> void:
	Events.scene_change_requested.emit(Locations.location_table.get(Locations.LocationEnum.HUB).path, {})
	return
