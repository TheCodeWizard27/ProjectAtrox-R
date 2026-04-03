
class_name WarriorAirborneState
extends WarriorState

var _airborne_state: AirborneState = AirborneState.new()

func init(current_player: Player) -> void:
	super.init(current_player)
	_airborne_state.init(current_player)
	_airborne_state.transitioned_to.connect(transition_to)
	_airborne_state.transitioned_back.connect(transition_back)

func physics_update(delta: float) -> void:
	_airborne_state.physics_update(delta)
