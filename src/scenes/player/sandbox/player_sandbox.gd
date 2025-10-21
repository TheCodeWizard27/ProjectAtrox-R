extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		$Player.set_target($Marker3D if not $Player.target else null)
