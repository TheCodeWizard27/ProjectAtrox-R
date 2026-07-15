
class_name StateMachine
extends Node

signal transitioned(state_name)

@export var manual_init: bool = false
@export var initial_state: NodePath
@export var stack_size: int

@onready var current_state: State = get_node(initial_state)

var _registered_states: Array[State] = []
var _state_stack: Array[NodePath] = []

func get_all_states(discover: bool = false) -> Array[State]:
	if (discover):
		discover_states()
		
	return _registered_states

func transition_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	#print_debug("Transitioning to state ", target_state_path)
	
	if(not has_node(target_state_path)):
		return
	
	if(not current_state):
		return
	
	if(_state_stack.size() >= stack_size):
		_state_stack.resize(stack_size)
		
	_state_stack.push_back(target_state_path)
	
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(msg)
	
	emit_signal("transitioned", current_state.name)
	
func transition_back(msg: Dictionary = {}) -> void:
	if(_state_stack.is_empty()):
		transition_to(initial_state, msg)
		return
	
	transition_to(_state_stack.pop_back(), msg)

func process(delta: float) -> void: # Needs to be manually called!
	handle_result(current_state.update(delta))
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	handle_result(current_state.physics_update(delta))

func handle_result(result: StateResult) -> void:
	if (result.type == StateResult.Type.CONTINUE):
		return
	
	match(result.type):
		StateResult.Type.TRANSITION_TO:
			transition_to(result.target_state_path, result.msg)
		StateResult.Type.TRANSITION_BACK:
			transition_back(result.msg)

func discover_states(root_node: Node = null) -> void:
	root_node = self if root_node == null else root_node
	
	for node in root_node.get_children():
		if (node.get_child_count() > 0):
			# This is container so recursively check children for states
			discover_states(node)
			continue
		
		var state := node as State
		
		if (not state):
			continue
		
		print_debug("Detected State ", state)
		_registered_states.append(state)

func init() -> void:
	discover_states()
	assert(current_state, 'Please set an initial state.')
	
	current_state.enter()

func _ready() -> void:
	if (manual_init):
		return
	
	discover_states()
	assert(current_state, 'Please set an initial state.')
	
	current_state.enter()
