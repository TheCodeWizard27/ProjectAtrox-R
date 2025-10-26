extends Node3D
class_name Player

const mage_controller_path = "res://src/scenes/player/combat_classes/mage/mage_controller.tscn"
const ranger_controller_path = "res://src/scenes/player/combat_classes/ranger/ranger_controller.tscn"
const warrior_controller_path = "res://src/scenes/player/combat_classes/warrior/warrior_controller.tscn"

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var acceleration: float = Globals.PLAYER_ACCELERATION
@export var min_jump_height: float = Globals.PLAYER_MIN_JUMP_HEIGHT
@export var max_jump_height: float = Globals.PLAYER_MAX_JUMP_HEIGHT
@export var jump_time: float = Globals.PLAYER_JUMP_TIME
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var turn_speed: float = Globals.ENTITY_TURN_SPEED

@onready var hud: Hud = %Hud
@onready var state_machine: StateMachine = %StateMachine
@onready var body: CharacterBody3D = %Body
@onready var animator: PlayerAnimator = %PlayerAnimator
@onready var camera_mount: CameraController = %CameraMount
@onready var lock_on_ray: RayCast3D = %LockOnRay
@onready var camera: Camera3D = %Camera

@onready var _combat_class_container: PlaceholderNode = %CombatClassContainer

var status: PlayerStatus
var combat_class_controller: CombatClassController
var lock_on_target: Node3D
var is_dead: bool = false
var active: bool = true

func get_hit(damage: float, source: Node3D) -> void:
	status.current_health = max(status.current_health - damage, 0)

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status
	_load_combat_class(status.combat_class)

func process_movement(delta: float, speed_modifier: float = 1) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	move_dir = move_dir.rotated(Vector3.UP, camera_mount.rotation.y).normalized()
	
	# Calculate velocity with separated y component.
	var y_velocity = body.velocity.y
	body.velocity = move_dir * max_speed * speed_modifier
	body.velocity.y = y_velocity - Globals.GRAVITY * delta
	
	if (speed_modifier <= 0):
		return
	
	# Rotate Character body	
	if (move_dir.length() > turn_threshold):
		var target_angle = Vector3.BACK.signed_angle_to(move_dir, Vector3.UP)
		body.rotation.y = lerp_angle(body.rotation.y, target_angle, delta)
	
func _ready() -> void:
	configure_player(PlayerStatus.new())

func _set_camera_active(value: bool) -> void:
	camera_mount.active = value

func _process(delta: float) -> void:
	assert(combat_class_controller, 'CombatClassController not set please call configure_player on _ready')

	if (!active):
		return
		
	if (is_dead):
		return
	
	if (status.current_health <= 0):
		is_dead = true
		animator.play_death()
	
	_process_lock_on(delta)
	
	combat_class_controller.process(delta)

func _physics_process(delta: float) -> void:
	assert(combat_class_controller, 'CombatClassController not set please call configure_player on _ready')

	if (!active):
		return
		
	if (is_dead):
		return
	
	combat_class_controller.physics_process(delta)
	_apply_movement(delta)

func _process_lock_on(delta: float) -> void:
	hud.update_target_indicator(lock_on_target, delta)
	camera_mount.lock_on_target = lock_on_target
	
	if (!Input.is_action_just_pressed("ui_focus_next")):
		return
	
	if (lock_on_target):
		lock_on_target = null
		return
	
	# Get all collisions by sequentially adding them to the exception list
	var ray_collisions = RayUtils.get_all_ray_intersections(lock_on_ray)
	
	var closest_collider: Node3D
	# Just some high initial value so any angle wins
	var closest_angle = 1000
	
	# Get lock on target closest to ray.
	for collider in ray_collisions:
		if (collider is not Node3D):
			continue
			
		var node = collider as Node3D
		var angle = camera.global_position.angle_to(node.global_position)
		
		if (angle < closest_angle):
			closest_collider = node
			closest_angle = angle
	
	lock_on_target = closest_collider

func _apply_movement(delta: float) -> void:
	body.move_and_slide()
	
	var movement = Vector2(body.velocity.x, body.velocity.z)
	
	if (movement.length() > turn_threshold):
		var target_angle = Quaternion(Vector3.UP, Vector2(body.velocity.z, body.velocity.x).angle())
		body.basis = body.basis.slerp(target_angle, turn_speed * delta)

func _load_combat_class(combat_class: Enums.CombatClasses) -> void:
	match (status.combat_class):
		Enums.CombatClasses.Mage:
			combat_class_controller = _combat_class_container.load_in(preload(mage_controller_path))
		Enums.CombatClasses.Ranger:
			combat_class_controller = _combat_class_container.load_in(preload(ranger_controller_path))
		Enums.CombatClasses.Warrior:
			combat_class_controller = _combat_class_container.load_in(preload(warrior_controller_path))

	combat_class_controller.init(self)
