extends PlayerState

# | ->
#           | cancel_time |
# | Startup | lag_time                |

@export var startup_time: float = 0.4
@export var cancel_time: float = 0.2
@export var lag_time: float = 0.4

var _attack_animation_finished: bool = false
var _attack_time: float

func enter(msg: Dictionary = {}) -> void:
	_attack_animation_finished = false
	_attack_time = 0
	animator.reset_falling_animation()
	animator.on_attack_finished.connect(_on_attack_finished)
	
	animator.play_attack(player.weapon.get_attack_type())
	player.weapon.play_attack()

func physics_update(delta: float) -> void:
	player.process_movement(delta, 0.4)
	animator.set_running(Vector2(body.velocity.x, body.velocity.z).length() * 0.1)
	
	_attack_time += delta
	
	var cancel_active = _attack_time > startup_time && _attack_time < startup_time + cancel_time 
	if(cancel_active && Input.is_action_just_pressed("attack")):
		animator.play_particles()
		transition_to(PlayerState.ATTACKING)
		return
	
	if(_attack_animation_finished && _attack_time >= startup_time + lag_time):
		transition_to(PlayerState.GROUNDED)
		return

func exit() -> void:
	animator.on_attack_finished.disconnect(_on_attack_finished)

func _on_attack_finished() -> void:
	_attack_animation_finished = true
