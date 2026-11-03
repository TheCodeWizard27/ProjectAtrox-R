class_name ActionHelper

# Make configurable
const _action_filter: Array[StringName] = [
	'jump', 'move_forward', 'move_backward', 'move_left', 'move_right', 'toggle_lock_on',
	'interact', 'primary_action', 'secondary_action', 'defensive_action', 'special_action'
]

static func resolve_actions(event: InputEvent) -> Array[ActionEvent]:
	var actions: Array[ActionEvent] = []
	
	for action in _action_filter:
		if (!event.is_action(action)):
			continue
		
		if(event.is_pressed()):
			actions.push_back(ActionEvent.new(action, true))
		elif (event.is_released()):
			actions.push_back(ActionEvent.new(action, false))
		
	return actions
