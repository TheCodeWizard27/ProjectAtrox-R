extends Player
class_name PlainClass

@export var state_machine: StateMachine

func _ready() -> void:
	super._ready()
	_init_state_machine()

func _init_state_machine() -> void:
	for state in state_machine.get_children():
		if state is PlayerState:
			state.init(self)

func _process(delta: float) -> void:
	super._process(delta)
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	state_machine.physics_process(delta)
