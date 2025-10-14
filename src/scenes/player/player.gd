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

@onready var _state: StateMachine = %State
@onready var body: CharacterBody3D = %Body
@onready var _animator: PlayerAnimator = %PlayerAnimator
@onready var _camera_mount: CameraController = %CameraMount
@onready var _weapon_placeholder: PlaceholderNode = %WeaponPlaceholder

@export var health = 10

var is_dead: bool = false

func _test_damage(damage: int) -> void:
	health -= damage

func _input(event: InputEvent):
	if Input.is_action_just_pressed("damage_test"):
		_test_damage(1)

func process_movement(delta: float, speed_modifier: float = 1) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	move_dir = move_dir.rotated(Vector3.UP, _camera_mount.rotation.y).normalized()
	
	# Calculate velocity with separated y component.
	var y_velocity = body.velocity.y
	body.velocity = move_dir * max_speed * speed_modifier
	body.velocity.y = y_velocity - Globals.GRAVITY * delta
	
	if(speed_modifier <= 0):
		return
	
	# Rotate Character body	
	if(move_dir.length() > turn_threshold):
		var target = Vector3.BACK.signed_angle_to(move_dir, Vector3.UP)
		body.rotation.y = lerp_angle(body.rotation.y, target, 10 * delta)

func _ready() -> void:
	pass

func _set_camera_active(value: bool) -> void:
	_camera_mount.active = value

func _process(delta: float) -> void:
	if(!active):
		return
		
	if(is_dead):
		return
	
	if(health <= 0):
		is_dead = true
		_animator.play_death()
	
	_state.process(delta)

func _physics_process(delta: float) -> void:
	if(!active):
		return
		
	if(is_dead):
		return
	
	_state.physics_process(delta)
	_apply_movement(delta)

func _apply_movement(delta: float) -> void:
	body.move_and_slide()
	
	var movement = Vector2(body.velocity.x, body.velocity.z)
	
	if(movement.length() > turn_threshold):
		var target = Quaternion(Vector3.UP, Vector2(body.velocity.z, body.velocity.x).angle())
		body.basis = body.basis.slerp(target, 0.2)
		
func get_hit(damage: float, source: Node3D) -> void:
	health = max(health - damage, 0)
