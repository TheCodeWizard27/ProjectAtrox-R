
class_name WarriorJumpingState
extends WarriorState

var _jumping_state: JumpingState = JumpingState.new()

func init(current_player: Player) -> void:
	super.init(current_player)
	_jumping_state.init(current_player)
	_jumping_state.transitioned_to.connect(transition_to)
	_jumping_state.transitioned_back.connect(transition_back)

func enter(msg: Dictionary = {}) -> void:
	_jumping_state.enter(msg)

func physics_update(delta: float) -> void:
	_jumping_state.physics_update(delta)
