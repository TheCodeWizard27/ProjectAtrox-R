class_name BroodEnemy
extends BaseEnemy
	
@onready var attack_box: Area3D = %AttackBox	
	
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
	
func move_towards_player(target: Player) -> void:
	if(is_near_player(target)):
		return
	
	var direction = body.global_position.direction_to(target._body.global_position)
	direction.y = 0
	body.velocity = direction * speed

func is_near_player(target: Player) -> bool:
	var distance = body.global_position.distance_to(target._body.global_position)
	return distance <= attack_distance

func attack() -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		(parent as Player).get_hit(attack_damage, self.body)
