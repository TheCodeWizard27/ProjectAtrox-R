extends BaseEntity
class_name Player

@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var turn_speed: float = Globals.ENTITY_TURN_SPEED

@export var body: CharacterBody3D
@export var camera_controller: CameraController
@export var camera: Camera3D
@export var model_animator: PlayerModelAnimator
@export var event_player: PlayerEventPlayer
@export var target_detector: TargetDetector

var status: PlayerStatus
var lock_on_target: Node3D

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status

func get_hit() -> void:
	super.get_hit()
	event_player.play_getting_hit()

func _ready() -> void:
	configure_player(PlayerStatus.new())

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	_apply_movement(delta)

func _apply_movement(delta: float) -> void:
	body.move_and_slide()
	
	#var movement = Vector2(body.velocity.x, body.velocity.z)
	
	#if (movement.length() > turn_threshold):
		#var target_angle = Quaternion(Vector3.UP, Vector2(body.velocity.z, body.velocity.x).angle())
		#body.basis = body.basis.slerp(target_angle, turn_speed * delta)
