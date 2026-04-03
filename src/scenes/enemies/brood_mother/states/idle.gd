class_name BroodMotherIdleState
extends BroodMotherState

const PLAYER = "player"

func enter(msg: Dictionary = {}) -> void:
	enemy.detected_player = null
	# A bit of a hack basically:
	# reset player_detector in case entered / exit event was missed.
	enemy.player_detector.monitoring = false
	enemy.player_detector.monitoring = true
	enemy.player_detector.body_entered.connect(_on_body_entered)

func exit() -> void:
	enemy.player_detector.body_entered.disconnect(_on_body_entered)
	
func physics_update(delta: float) -> void:
	if(enemy.detected_player == null):
		return
	
	const SPAWN: NodePath = ^"Spawn"
	transition_to(BroodMotherState.SPAWN, {PLAYER: enemy.detected_player})
	
func _on_body_entered(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		enemy.detected_player = parent as Player
