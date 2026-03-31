extends Player
class_name WarriorClass

@export var state_machine: StateMachine
@export var event_animator: AnimationPlayer

func _ready() -> void:
	super._ready()
	_init_state_machine()

func _init_state_machine() -> void:
	for state in state_machine.get_children():
		if state is WarriorState:
			state.init(self)

func _process(delta: float) -> void:
	super._process(delta)
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	state_machine.physics_process(delta)
