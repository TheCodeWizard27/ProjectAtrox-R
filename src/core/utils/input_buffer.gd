class_name InputBuffer

var _buffered_events: Array[InputEvent] = []

func push_event(event: InputEvent) -> void:
	_buffered_events.push_back(event)
	
func clear() -> void:
	_buffered_events.clear()
	
func is_action_pressed(action: StringName, exact_match: bool) -> bool:
	return _buffered_events.any(func(event): return _is_action_pressed(event, action, exact_match))

func is_action_just_pressed(action: StringName, exact_match: bool) -> bool:
	return _buffered_events.any(func(event): return _is_action_just_pressed(event, action, exact_match))

func is_action_just_released(action: StringName, exact_match: bool) -> bool:
	return _buffered_events.any(func(event): return _is_action_just_released(event, action, exact_match))

func _is_action_pressed(event: InputEvent, action: StringName, exact_match: bool) -> bool:
	return event.is_action_pressed(action, exact_match)
	
func _is_action_just_released(event: InputEvent, action: StringName, exact_match: bool) -> bool:
	return event.is_action_pressed(action, exact_match)
	
func _is_action_just_pressed(event: InputEvent, action: StringName, exact_match: bool) -> bool:
	return event.is_action_pressed(action, exact_match)
