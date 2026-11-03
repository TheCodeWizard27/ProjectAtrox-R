class_name ActionBuffer

var _previous_buffered_actions: Array[StringName] = []
var _buffered_actions: Array[StringName] = []

func set_action_pressed(action: StringName) -> void:
	if (!_buffered_actions.has(action)):
		_buffered_actions.push_back(action)

func set_action_release(action: StringName) -> void:
	if (_buffered_actions.has(action)):
		_buffered_actions.erase(action)

func push_events(events: Array[ActionEvent]) -> void:
	for event in events:
		if (!_buffered_actions.has(event.action) and event.is_pressed):
			_buffered_actions.push_back(event.action)
		elif (_buffered_actions.has(event.action) and !event.is_pressed):
			_buffered_actions.erase(event.action)

func push_event(event: InputEvent) -> void:
	push_events(ActionHelper.resolve_actions(event))

func clear() -> void:
	_previous_buffered_actions.clear()
	_buffered_actions.clear()
	
func update() -> void:
	_previous_buffered_actions.clear()
	_previous_buffered_actions.append_array(_buffered_actions)
	#_buffered_actions.clear()

func is_action_pressed(action: StringName, _exact_match: bool = false) -> bool:
	return _buffered_actions.has(action)

func is_action_just_pressed(action: StringName, _exact_match: bool = false) -> bool:
	return _buffered_actions.has(action) and !_previous_buffered_actions.has(action)

func is_action_just_released(action: StringName, _exact_match: bool = false) -> bool:
	return !_buffered_actions.has(action) and _previous_buffered_actions.has(action)

func get_vector(negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName) -> Vector2:	
	return Vector2(
		get_action_strength(positive_x) - get_action_strength(negative_x),
		get_action_strength(positive_y) - get_action_strength(negative_y)
	)
	
func get_action_strength(action: StringName) -> float:
	# Not implemented yet
	return 1 if _buffered_actions.has(action) else 0
