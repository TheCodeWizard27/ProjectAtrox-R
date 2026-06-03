extends Node3D
class_name PlayerController

@export var ui_container: Node3D
@export var camera_controller: CameraController
@export var pause_menu: PauseMenu
@export var hud: Hud
@export var state_machine: StateMachine

@export var target_player: Player = null

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:	
	for state in state_machine.get_all_states(true):
		if state is PlayerControllerState:
			state.init(self)
	
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
