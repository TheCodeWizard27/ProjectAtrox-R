extends Node3D
class_name PlayerController

@export var ui_container: Node3D
@export var camera_controller: CameraController
@export var pause_menu: PauseMenu
@export var hud: Hud
@export var state_machine: StateMachine
@export var lock_on_target_detector: LockOnTargetDetector

@export var target_player: Player:
	set(new_player):
		_configure_new_player(new_player)
	get: return _target_player

var _target_player: Player = null

func _ready() -> void:
	_init_state_machine()

func _configure_new_player(player: Player) -> void:
	if (_target_player != null):
		pause_menu.unsubscribe_for_player(_target_player)
	
	_target_player = player
	pause_menu.subscribe_for_player(_target_player)

func _init_state_machine() -> void:	
	for state in state_machine.get_all_states(true):
		if state is PlayerControllerState:
			state.init(self)
	
	state_machine.init()

func _process(delta: float) -> void:
	state_machine.process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
