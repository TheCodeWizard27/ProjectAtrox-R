class_name BroodEnemy
extends BaseEnemy

@onready var attack_box: Area3D = %AttackBox	
@onready var navigation_agent = $Body/NavigationAgent3D

func _ready() -> void:
	attack_box.body_entered.connect(_on_body_entered)
	current_health = max_health

func _process(delta: float) -> void:
	super._process(delta)
	
	if(current_health > 0):
		return
	
	# Hacky way fix up in future
	process_mode = Node.PROCESS_MODE_DISABLED
	get_parent().remove_child(self)

func is_near_player(target: Player) -> bool:
	var distance = body.global_position.distance_to(target.body.global_position)
	return distance <= attack_distance

func attack() -> void:
	
	pass

func _on_body_entered(p_body: Node3D) -> void:
	var parent = p_body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		pass
		#(parent as Player).get_hit(attack_damage, self.body)
