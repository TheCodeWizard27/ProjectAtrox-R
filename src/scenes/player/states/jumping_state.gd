class_name JumpingState
extends PlayerState

@export var min_jump_height: float = 0.8
@export var max_jump_height: float = 1.2

var _min_velocity: float
var _max_velocity: float
var _min_jump_time: float
var _max_jump_time: float
var _jump_time: float
var _min_gravity: float

var movement_processor: PlayerMovementProcessor
var lock_on_processor: PlayerLockOnProcessor

func init(current_player: Player) -> void:
	super.init(current_player)
	lock_on_processor = PlayerLockOnProcessor.new(current_player)
	movement_processor = PlayerMovementProcessor.new(current_player)

func enter(_msg: Dictionary = {}) -> void:
	_jump_time = 0
	
	_min_velocity = sqrt(min_jump_height * 2 * Globals.GRAVITY)
	_max_velocity = sqrt(max_jump_height * 2 * Globals.GRAVITY)
	_min_gravity = (2 * (_max_velocity ** 2)) / min_jump_height
	
	_min_jump_time = _min_velocity / _min_gravity
	_max_jump_time = _max_velocity / Globals.GRAVITY
	
	body.velocity.y = _max_velocity

func physics_update(delta: float) -> void:
	
	model_animator.advance_falling_to(1, delta)
	
	var still_jumping = Input.is_action_pressed("jump")
	if(_min_jump_time <= _jump_time && !still_jumping || still_jumping && _max_jump_time <= _jump_time):
		transition_to(PlayerState.AIRBORNE)
		return
	
	if(!still_jumping):
		body.velocity.y -= abs(_min_gravity - Globals.GRAVITY) * delta
	
	movement_processor.process_movement(delta)
	lock_on_processor.process_lock_on()
	
	_jump_time += delta
