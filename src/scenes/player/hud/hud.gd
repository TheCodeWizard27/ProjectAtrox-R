extends Node3D
class_name Hud

@onready var _target_indicator: MeshInstance3D = $TargetIndicator

func update_target_indicator(target: Node3D, delta: float) -> void:
	if (!target):
		_target_indicator.hide()
		return
		
	_target_indicator.show()
	_target_indicator.global_position = target.global_position
