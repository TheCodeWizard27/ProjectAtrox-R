extends Player
class_name PlainClass

@onready var stateMachine: StateMachine = %StateMachine

func _init() -> void:
	_init_state_machine()

func _init_state_machine() -> void:
	for state in stateMachine.get_children():
		if state is PlayerState:
			state.init(self)
	

func _process(delta: float) -> void:
	super._process(delta)
	stateMachine.process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	stateMachine.physics_process(delta)
