class_name Player
extends Node3D

@export var active: bool = true:
	get:
		return active
	set(value):
		active = value
		Utils.call_when_ready(self, func(): _set_camera_active(value))

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var acceleration: float = Globals.PLAYER_ACCELERATION
@export var min_jump_height: float = Globals.PLAYER_MIN_JUMP_HEIGHT
@export var max_jump_height: float = Globals.PLAYER_MAX_JUMP_HEIGHT
@export var jump_time: float = Globals.PLAYER_JUMP_TIME
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD

@onready var _state: StateMachine = %StateMachine
@onready var _body: CharacterBody3D = %Body
@onready var _animator: PlayerAnimator = %PlayerAnimator
@onready var _camera_mount: CameraController = %CameraMount

var status: PlayerStatus
var currency: int
var is_dead: bool = false

var target: Node3D

func _test_damage(damage: int) -> void:
	status.current_health -= damage

func process_movement(delta: float, speed_modifier: float = 1) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	move_dir = move_dir.rotated(Vector3.UP, _camera_mount.rotation.y).normalized()
	
	# Calculate velocity with separated y component.
	var y_velocity = _body.velocity.y
	_body.velocity = move_dir * max_speed * speed_modifier
	_body.velocity.y = y_velocity - Globals.GRAVITY * delta
	
	if(speed_modifier <= 0):
		return
	
	# Rotate Character body	
	if(move_dir.length() > turn_threshold):
		var target = Vector3.BACK.signed_angle_to(move_dir, Vector3.UP)
		_body.rotation.y = lerp_angle(_body.rotation.y, target, 10 * delta)
	
func _ready() -> void:
	configure_player(PlayerStatus.new())
	pass

func _set_camera_active(value: bool) -> void:
	_camera_mount.active = value

func _process(delta: float) -> void:
	if(!active):
		return
		
	if(is_dead):
		return
	
	if(status.current_health <= 0):
		is_dead = true
		_animator.play_death()
	
	if (target):
		var rotation = _camera_mount.rotation
		_camera_mount.look_at_from_position(_camera_mount.position, target.position, Vector3.UP)
		_camera_mount.rotation.x = rotation.x
		_camera_mount.rotation.z = rotation.z
	
	_state.process(delta)

func _physics_process(delta: float) -> void:
	if(!active):
		return
		
	if(is_dead):
		return
	
	_state.physics_process(delta)
	_apply_movement(delta)

func _apply_movement(delta: float) -> void:
	_body.move_and_slide()
	
	var movement = Vector2(_body.velocity.x, _body.velocity.z)
	
	if(movement.length() > turn_threshold):
		var target = Quaternion(Vector3.UP, Vector2(_body.velocity.z, _body.velocity.x).angle())
		_body.basis = _body.basis.slerp(target, 0.2)
		
func get_hit(damage: float, source: Node3D) -> void:
	status.current_health = max(status.current_health - damage, 0)

func set_target(new_target: Node3D) -> void:
	target = new_target

func configure_player(newStats: PlayerStatus) -> void:
	status = newStats
