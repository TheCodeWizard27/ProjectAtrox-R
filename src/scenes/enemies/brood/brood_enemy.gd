extends BaseEnemy
class_name BroodEnemy

@onready var attack_box: Area3D = %AttackBox	
@onready var navigation_agent = $Body/NavigationAgent3D
@export var hit_player: AnimationPlayer
var got_hit = false

func _ready() -> void:
	attack_box.area_entered.connect(_on_body_entered)
	current_health = max_health

func _process(delta: float) -> void:
	super._process(delta)
	
	if(current_health > 0):
		return

func is_near_player(target: Player) -> bool:
	var distance = body.global_position.distance_to(target.body.global_position)
	return distance <= attack_distance

func attack() -> void:
	
	pass

func get_hit() -> void:
	got_hit = true

func destroy() -> void:
	queue_free()

func _on_body_entered(p_body: Node3D) -> void:
	var entity = EntityResolveUtil.resolve_entity(p_body)
	
	if (entity != null):
		entity.get_hit()
