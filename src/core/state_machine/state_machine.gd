
class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state: NodePath
@export var stack_size: int

@onready var current_state: State = get_node(initial_state)

var registered_states: Array[State] = []
var _state_stack: Array[NodePath] = []

func _ready():
	discover_states()
	assert(current_state, 'Please set an initial state.')
	current_state.enter()

func transition_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	print_debug("Transitioning to state ", target_state_path)
	
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
	
func transition_from(msg: Dictionary = {}) -> void:
	if(_state_stack.is_empty()):
		transition_to(initial_state, msg)
	
	transition_to(_state_stack.pop_back(), msg)

func process(delta: float) -> void: # Needs to be manually called!
	current_state.update(delta)
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	current_state.physics_update(delta)

func discover_states(root_node: Node = null) -> void:
	root_node = self if root_node == null else root_node
	
	if (root_node == self):
		_cleanup_states()
	
	for node in get_children():
		if (node.get_child_count() > 0):
			# This is container so recursively check children for states
			discover_states(node)
			continue
		
		var state := node as State
		
		if (not state):
			continue
		
		print_debug("Detected State ", state)
		registered_states.append(state)
		state.connect("transitioned_to", _on_transitioned_to)
		state.connect("transitioned_back", _on_transitioned_from)

func _on_transitioned_to(target_state_path: NodePath, msg: Dictionary = {}) -> void:
	transition_to(target_state_path, msg)
	
func _on_transitioned_from(msg: Dictionary = {}) -> void:
	transition_from(msg)

func _cleanup_states() -> void:
	for state in registered_states:
		state.disconnect("transitioned_to", _on_transitioned_to)
		state.disconnect("transitioned_back", _on_transitioned_from)
