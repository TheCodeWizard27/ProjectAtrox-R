
class_name WarriorPrimaryActionState
extends WarriorState

class PrimaryAttackData:
	var blend_position: WarriorModelAnimator.PrimaryAttackBlendPositions
	var event_animation: String
	var cancel_window_start: float
	var max_duration: float
	
	func _init(
		p_event_animation: String,
		p_blend_position: WarriorModelAnimator.PrimaryAttackBlendPositions, 
		p_cancel_window_start: float, 
		p_max_duration: float
		):
		event_animation = p_event_animation
		blend_position = p_blend_position
		cancel_window_start = p_cancel_window_start
		max_duration = p_max_duration

static var attack_step_parameter = "attack_step"

var attack_steps: Array[PrimaryAttackData] = [
	PrimaryAttackData.new(
		'Primary_Attack_Step_1',
		WarriorModelAnimator.PrimaryAttackBlendPositions.ATTACK1,
		0.2,
		0.45
	),
	PrimaryAttackData.new(
		'Primary_Attack_Step_2',
		WarriorModelAnimator.PrimaryAttackBlendPositions.ATTACK2,
		0.2,
		0.41
	),
	PrimaryAttackData.new(
		'Primary_Attack_Step_3',
		WarriorModelAnimator.PrimaryAttackBlendPositions.ATTACK3,
		0.2,
		0.625
	)
]

var input_buffer_delay: float = 0.1
var movement_speed_modifier: float = 0.2

var current_step_index: int = 0
var current_step: PrimaryAttackData = null
var current_time: float = 0
var primary_attack_buffered: bool = false

var movement_processor: PlayerMovementProcessor
var lock_on_processor: PlayerLockOnProcessor

func init(current_player: WarriorClass) -> void:
	super.init(current_player)
	lock_on_processor = PlayerLockOnProcessor.new(current_player)
	movement_processor = PlayerMovementProcessor.new(current_player)

func enter(_msg: Dictionary = {}) -> void:
	var attack_step = _msg.get(attack_step_parameter)
	_init_attack_step(attack_step if attack_step is float else 0)

func physics_update(delta: float) -> void:
	process_attack(delta)
	movement_processor.process_movement(delta, movement_speed_modifier)
	lock_on_processor.process_lock_on()
	
	model_animator.set_running(Vector2(body.velocity.x, body.velocity.z).length() * movement_speed_modifier)

func process_attack(delta: float) -> void:
	current_time += delta
	
	if (current_time >= input_buffer_delay and Input.is_action_pressed('primary_action')):
		primary_attack_buffered = true
	
	var step_end_reached = current_time >= current_step.max_duration
	
	if (step_end_reached):
		if(primary_attack_buffered and current_step_index < attack_steps.size() - 1):
			return _init_attack_step(current_step_index + 1)
		
		transition_to(WarriorState.GROUNDED)

func _init_attack_step(step: int) -> void:
	primary_attack_buffered = false
	current_time = 0
	current_step_index = step
	current_step = attack_steps[step]
	model_animator.play_primary_attack(current_step.blend_position)
	event_animator.play(current_step.event_animation)
