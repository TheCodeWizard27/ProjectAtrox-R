extends Node3D
class_name Player

const mage_controller_path = "res://src/scenes/player/combat_classes/mage/mage_controller.tscn"
const ranger_controller_path = "res://src/scenes/player/combat_classes/ranger/ranger_controller.tscn"
const warrior_controller_path = "res://src/scenes/player/combat_classes/warrior/warrior_controller.tscn"

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var turn_speed: float = Globals.ENTITY_TURN_SPEED

@export var body: CharacterBody3D
@export var camera_mount: CameraController
@export var camera: Camera3D

@onready var hud: Hud = %Hud
@onready var animator: OldPlayerAnimator = %PlayerAnimator
@onready var lock_on_ray: RayCast3D = %LockOnRay

var status: PlayerStatus
var lock_on_target: Node3D
var is_dead: bool = false
var active: bool = true

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status

func process_movement(delta: float, speed_modifier: float = 1) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
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
	pass
	#if (Input.is_key_pressed(KEY_1)):
		#animator.play_attack()
		#
	#if (Input.is_key_pressed(KEY_2)):
		#animator.play_interact()
	
	#_process_lock_on(delta)

func _physics_process(delta: float) -> void:
	if (!active):
		return
		
	if (is_dead):
		return
	
	_apply_movement(delta)

#func _process_lock_on(delta: float) -> void:
	#hud.update_target_indicator(lock_on_target, delta)
	#camera_mount.lock_on_target = lock_on_target
	#
	#if (!Input.is_action_just_pressed("toggle_lock_on")):
		#return
	#
	#if (lock_on_target):
		#lock_on_target = null
		#return
	#
	## Get all collisions by sequentially adding them to the exception list
	#var ray_collisions = RayUtils.get_all_ray_intersections(lock_on_ray)
	#
	#var closest_collider: Node3D
	## Just some high initial value so any angle wins
	#var closest_angle = 1000
	#
	## Get lock on target closest to ray.
	#for collider in ray_collisions:
		#if (collider is not Node3D):
			#continue
			#
		#var node = collider as Node3D
		#var angle = camera.global_position.angle_to(node.global_position)
		#
		#if (angle < closest_angle):
			#closest_collider = node
			#closest_angle = angle
	#
	#lock_on_target = closest_collider

func _apply_movement(delta: float) -> void:
	body.move_and_slide()
	
	var movement = Vector2(body.velocity.x, body.velocity.z)
	
	if (movement.length() > turn_threshold):
		var target_angle = Quaternion(Vector3.UP, Vector2(body.velocity.z, body.velocity.x).angle())
		body.basis = body.basis.slerp(target_angle, turn_speed * delta)
