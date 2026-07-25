class_name StateResult

enum Type {
	CONTINUE,
	TRANSITION_TO,
	TRANSITION_BACK
}

static var continue_result = StateResult.new(Type.CONTINUE, '', {})

var type: Type
var target_state_path: NodePath
var msg: Dictionary

func _init(p_type: Type, p_target_state_path: NodePath, p_msg: Dictionary = {}):
	type = p_type
	target_state_path = p_target_state_path
	msg = p_msg
	
static func transition_to(p_target_state_path: NodePath, p_msg: Dictionary = {}) -> StateResult:
	return StateResult.new(Type.TRANSITION_TO, p_target_state_path, p_msg)

static func transition_back(p_msg: Dictionary = {}) -> StateResult:
	return StateResult.new(Type.TRANSITION_BACK, '', p_msg)
