extends WarriorState

var _grounded_state: GroundedState = GroundedState.new()

func init(current_player: Player, current_controller: WarriorController) -> void:
	super.init(current_player, current_controller)
	_grounded_state.init(current_player)
	_grounded_state.transitioned_to.connect(transition_to)
	_grounded_state.transitioned_back.connect(transition_back)

func physics_update(delta: float) -> void:
	_grounded_state.physics_update(delta)
	
	if(Input.is_action_just_pressed('primary_action')):
		transition_to(WarriorState.WARRIOR_PRIMARY_ACTION)
