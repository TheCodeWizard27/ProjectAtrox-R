class_name BroodMotherIdleState
extends BroodMotherState

const PLAYER = "player"

func enter(_msg: Dictionary = {}) -> void:
	enemy.detected_player = null
	# A bit of a hack basically:
	# reset player_detector in case entered / exit event was missed.
	enemy.player_detector.monitoring = false
	enemy.player_detector.monitoring = true
	enemy.player_detector.body_entered.connect(_on_body_entered)

func exit() -> void:
	enemy.player_detector.body_entered.disconnect(_on_body_entered)
	
func physics_update(_delta: float) -> StateResult:
	if(enemy.detected_player == null):
		return StateResult.continue_result
	
	return StateResult.transition_to(BroodMotherState.SPAWN, {PLAYER: enemy.detected_player})
	
func _on_body_entered(body: Node3D) -> void:
	var player = EntityResolveUtil.resolve_player(body)
	
	if(player != null):
		enemy.detected_player = player
