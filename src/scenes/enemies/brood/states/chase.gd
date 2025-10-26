class_name BroodChaseState
extends BroodState

var _attack_cooldown: float
var _detected_player: Player

func enter(msg: Dictionary = {}) -> void:
	_detected_player = msg[BroodGuardState.PLAYER]
	enemy.player_detector.body_exited.connect(_on_body_exit)
	
func exit() -> void:
	enemy.player_detector.body_exited.disconnect(_on_body_exit)
	
func physics_update(delta: float) -> void:
	if(_detected_player == null):
		transition_to(BroodState.GUARD)
		return
	
	_attack_cooldown -= delta
	if(_attack_cooldown <= 0 && enemy.is_near_player(_detected_player)):
		_attack_cooldown = enemy.attack_cooldown
		transition_to(BroodState.ATTACK)
		return
		
	enemy.navigation_agent.set_target_position(_detected_player.body.global_position)
	var destination = enemy.navigation_agent.get_next_path_position()
	var local_destination = destination - enemy.body.global_position
	var direction = local_destination.normalized()

	enemy.body.velocity = direction * enemy.speed


func _on_body_exit(body: Node3D) -> void:
	if(_detected_player == null || body == _detected_player.body):
		_detected_player = null
