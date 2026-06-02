extends Node3D
class_name PlayerController

@export var camera_controller: CameraController
@export var state_machine: StateMachine

func _ready() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	for state in state_machine.registered_states:
		if state is PlayerControllerState:
			state.init(self)

func _process(delta: float) -> void:
	state_machine.process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
