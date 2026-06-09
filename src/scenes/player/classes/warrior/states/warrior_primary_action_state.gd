
class_name WarriorPrimaryActionState
extends WarriorState

class PrimaryAttackData:
	var blend_position: WarriorModelAnimator.WarriorActionBlendPosition
	var effect_step_type: WarriorEventPlayer.PrimaryAttackSteps
	var cancel_window_start: float
	var max_duration: float
	
	func _init(
		p_effect_step_type: WarriorEventPlayer.PrimaryAttackSteps,
		p_blend_position: WarriorModelAnimator.WarriorActionBlendPosition, 
		p_cancel_window_start: float, 
		p_max_duration: float
		):
		effect_step_type = p_effect_step_type
		blend_position = p_blend_position
		cancel_window_start = p_cancel_window_start
		max_duration = p_max_duration

static var attack_step_parameter = "attack_step"

var attack_steps: Array[PrimaryAttackData] = [
	PrimaryAttackData.new(
		WarriorEventPlayer.PrimaryAttackSteps.STEP_1,
		WarriorModelAnimator.WarriorActionBlendPosition.PRIMARY_ATTACK_1,
		0.2,
		0.45
	),
	PrimaryAttackData.new(
		WarriorEventPlayer.PrimaryAttackSteps.STEP_2,
		WarriorModelAnimator.WarriorActionBlendPosition.PRIMARY_ATTACK_2,
		0.2,
		0.41
	),
	PrimaryAttackData.new(
		WarriorEventPlayer.PrimaryAttackSteps.STEP_3,
		WarriorModelAnimator.WarriorActionBlendPosition.PRIMARY_ATTACK_3,
		0.2,
		0.625
	)
]

var input_buffer_delay: float = 0.2
var movement_speed_modifier: float = 0.2
var forward_momentum: float = 1

var current_step_index: int = 0
var current_step: PrimaryAttackData = null
var current_time: float = 0
var primary_attack_buffered: bool = false

var movement_processor: PlayerMovementProcessor

func init(current_player: Player) -> void:
	super.init(current_player)
	
	movement_processor = PlayerMovementProcessor.new(current_player)

func enter(_msg: Dictionary = {}) -> void:
	if (player.lock_on_target != null):
		movement_processor.look_at(player.lock_on_target.global_position)
	
	var attack_step = _msg.get(attack_step_parameter)
	_init_attack_step(attack_step if attack_step is float else 0)

func physics_update(delta: float) -> void:
	process_attack(delta)
	movement_processor.process_movement(delta, movement_speed_modifier)
	
	# Lead towards look direction
	var forward = (Vector3.FORWARD * forward_momentum).rotated(Vector3.UP, Basis.looking_at(player.looking_direction).get_euler().y)
	player.body.velocity += forward
	movement_processor.look_at(player.body.position - forward)
	
	model_animator.set_running(Vector2(body.velocity.x, body.velocity.z).length() * movement_speed_modifier)

func process_attack(delta: float) -> void:
	current_time += delta
	
	if (current_time >= input_buffer_delay and player.input_buffer.is_action_pressed('primary_action')):
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
	
	model_animator.warrior_animator.play_action(current_step.blend_position)
	event_player.warrior_event_player.play_primary_effect(current_step.effect_step_type)

func _resolve_hit(area: Area3D) -> void:
	var entity = EntityResolveUtil.resolve_entity(area)
	
	if (entity != null):
		entity.get_hit()

func _on_step_1_hurtbox_area_entered(area: Area3D) -> void:
	_resolve_hit(area)

func _on_step_2_hurtbox_area_entered(area: Area3D) -> void:
	_resolve_hit(area)

func _on_step_3_hurtbox_area_entered(area: Area3D) -> void:
	_resolve_hit(area)
