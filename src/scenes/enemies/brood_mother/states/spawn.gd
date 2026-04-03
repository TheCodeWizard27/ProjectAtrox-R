class_name BroodMotherSpawnState
extends BroodMotherState

@export var spawn_scene: PackedScene

const PLAYER = "player"

var _attack_cooldown: float

var max_brood_size: int = 3
var current_brood_size: int = 0

func enter(_msg: Dictionary = {}) -> void:
	enemy.player_detector.body_exited.connect(_on_player_exit)
	enemy.buff_box.body_entered.connect(_on_brood_enter)
	enemy.buff_box.body_exited.connect(_on_brood_exit)

func exit() -> void:
	enemy.player_detector.body_exited.disconnect(_on_player_exit)
	enemy.buff_box.body_entered.disconnect(_on_brood_enter)
	enemy.buff_box.body_exited.disconnect(_on_brood_exit)
	
func physics_update(delta: float) -> void:
	if(enemy.detected_player == null):
		transition_to(BroodMotherState.IDLE, {PLAYER: enemy.detected_player})
		
	if(current_brood_size < 3):
		_attack_cooldown -= delta
		if(_attack_cooldown <= 0 ):
			_attack_cooldown = enemy.attack_cooldown
			spawn()
	

func spawn(_spawn_scene := spawn_scene) -> void:
	var spawn_instance: Node3D = enemy.spawns[current_brood_size -1].load_in(_spawn_scene)
	spawn_instance.global_position.x = enemy.global_position.x + 1
	spawn_instance.global_position.z = enemy.global_position.z + 1 
	current_brood_size += 1
	
func _on_brood_enter(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("brood" in parent.get_groups()):
		current_brood_size += 1

func _on_brood_exit(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("brood" in parent.get_groups()):
		current_brood_size -= 1
		

func _on_player_exit(body: Node3D) -> void:
	print_debug('TestSpawn: entering player exit', body)
	if(enemy.detected_player == null || body == enemy.detected_player.body):
		enemy.detected_player = null
		print_debug('TestSpawn: going for a clear', body)
		enemy.spawns[current_brood_size -1].clear()
		current_brood_size =- 1
