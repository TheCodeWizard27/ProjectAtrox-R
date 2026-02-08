extends Node3D
class_name Hud

@onready var _target_indicator: Node3D = $TargetIndicator
@onready var _health_bar: MeshInstance3D = $Health/Health
@onready var _combat_class_hud: PlaceholderNode = $CombatClassHud

func load_in_combat_class(scene: Node) -> void:
	_combat_class_hud.replace_in(scene)

func update_target_indicator(target: Node3D, delta: float) -> void:
	if (!target):
		_target_indicator.hide()
		return
		
	_target_indicator.show()
	_target_indicator.global_position = target.global_position

func update_health(new_value: float) -> void:
	var mat = _health_bar.mesh.surface_get_material(0)
	mat.set("shader_parameter/size", new_value)
