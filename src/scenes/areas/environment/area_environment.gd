@tool
extends Node3D
class_name AreaEnvironment

@onready var sun: DirectionalLight3D = $Sun
@onready var moon: DirectionalLight3D = $Moon

# Normalized time from 0.0 to 0.1
var _time: float = 0.5
@export_range(0.0, 1.0) var time: float:
	get:
		return _time
	set(value):
		_time = value
		
		if(sun and moon):
			_update_sun_and_moon()
		
func _update_sun_and_moon() -> void:
	sun.rotation.x = deg_to_rad(_time * 360)
	moon.rotation.x = deg_to_rad(_time * 360 - 180.0)
		
func _ready() -> void:
	_update_sun_and_moon()
