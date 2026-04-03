extends Node3D
class_name Hud

@export var player: Player

@onready var _target_indicator: Node3D = $TargetIndicator
@onready var _health_bar: MeshInstance3D = $Health/Health

func _process(delta: float) -> void:
	if (not is_instance_valid(player.lock_on_target)):
		player.lock_on_target = null
		
	update_target_indicator(player.lock_on_target, delta)
	update_health(player.status.current_health if player.status != null else 0)

func update_target_indicator(target: Node3D, _delta: float) -> void:
	if (!target):
		_target_indicator.hide()
		return
		
	_target_indicator.show()
	_target_indicator.global_position = target.global_position

func update_health(new_value: float) -> void:
	var mat = _health_bar.mesh.surface_get_material(0)
	mat.set("shader_parameter/size", new_value)
