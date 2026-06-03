class_name BroodGuardState
extends BroodState

const PLAYER = "player"

var _detected_player: Player

func enter(_msg: Dictionary = {}) -> void:
	_detected_player = null
	# A bit of a hack basically:
	# reset player_detector in case entered / exit event was missed.
	enemy.player_detector.monitoring = false
	enemy.player_detector.monitoring = true
	enemy.player_detector.body_entered.connect(_on_body_entered)

func exit() -> void:
	enemy.player_detector.body_entered.disconnect(_on_body_entered)
	
func physics_update(_delta: float) -> void:
	process_damage_taken()
	if(_detected_player == null):
		return
	
	transition_to(BroodState.CHASE, {PLAYER: _detected_player})
	
func _on_body_entered(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		_detected_player = parent as Player
