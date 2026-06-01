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

var input_buffer: InputBuffer
var status: PlayerStatus
var lock_on_target: Node3D

func configure_player(new_status: PlayerStatus) -> void:
	status = new_status

func get_hit() -> void:
	super.get_hit()
	status.current_health -= 1 # TODO
	event_player.play_getting_hit()

func _ready() -> void:
	configure_player(PlayerStatus.new())

func _process(delta: float) -> void:
	_process_state(delta)
	input_buffer.clear()
	
func _process_state(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	_apply_movement(delta)

func _apply_movement(_delta: float) -> void:
	body.move_and_slide()

func _input(event: InputEvent) -> void:
	input_buffer.push_event(event)
