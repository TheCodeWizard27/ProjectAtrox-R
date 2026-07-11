extends Entity
class_name Player

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var turn_speed: float = Globals.ENTITY_TURN_SPEED

@export var body: CharacterBody3D
@export var target_detector: TargetDetector
@export var event_player: PlayerEventPlayer
@export var model_animator: PlayerModelAnimator
@export var state_machine: StateMachine
@export var camera_anchor: Marker3D

var looking_direction: Vector3 = Vector3.FORWARD
var input_buffer: InputBuffer = InputBuffer.new()
var status: PlayerStatus
var lock_on_target: Node3D

var primary_action_state: NodePath
var secondary_action_state: NodePath
var defensive_action_state: NodePath
var special_action_state: NodePath

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status
	
	# Simple mesh replacement test.
	var skeleton: Skeleton3D = $Body/CharacterModel/metarig/Skeleton3D
	
	var other_skin = preload("res://src/assets/models/player/character_model_2.tscn").instantiate()
	var other_skin_skeleton = other_skin.get_node('metarig').get_node('Skeleton3D')
	
	var mesh_names: Array[String] = [
		'Head',
		'Arms',
		'LowerBody',
		'Legs'
	]
	
	for mesh_path in mesh_names:
		skeleton.remove_child(skeleton.get_node(mesh_path))
		var new_mesh_node = other_skin_skeleton.get_node(mesh_path)
		other_skin_skeleton.remove_child(new_mesh_node)
		skeleton.add_child(new_mesh_node)
	
	_init_class_actions()

func get_hit() -> void:
	super.get_hit()
	status.current_health -= 1 # TODO
	event_player.play_getting_hit()

func push_event(event: InputEvent) -> void:
	input_buffer.push_event(event)

func _ready() -> void:
	_init_state_machine()
	configure_player(PlayerStatus.new())

func _init_state_machine() -> void:
	for state in state_machine.get_all_states(true):
		if state is PlayerState:
			state.init(self)

func _process(delta: float) -> void:
	state_machine.process(delta)
	status.play_time += delta

func _physics_process(delta: float) -> void:	
	state_machine.physics_process(delta)
	body.move_and_slide()
	input_buffer.update()

func _init_class_actions() -> void:
	match status.combat_class:
		Enums.CombatClasses.WARRIOR:
			primary_action_state = WarriorState.WARRIOR_PRIMARY_ACTION
			secondary_action_state = WarriorState.WARRIOR_SECONDARY_ACTION
			defensive_action_state = WarriorState.WARRIOR_DEFENSIVE_ACTION
			special_action_state = WarriorState.WARRIOR_SPECIAL_ACTION
