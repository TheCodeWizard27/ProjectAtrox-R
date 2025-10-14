class_name CameraController
extends Node3D

@export_range(0, 1) var mouse_sensitivity: float = 0.2
@export var active: bool = true:
	get:
		return active
	set(value):
		active = value
		active_changed.emit(value)

signal active_changed

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if(!active):
		return
	
	if(event.is_action("click")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event.is_action_pressed("toggle_mouse_captured")):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if(event is InputEventMouseMotion):
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = lerpf(rotation_degrees.x, clamp(rotation_degrees.x, -90, 30), 1)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = lerpf(rotation_degrees.y, wrapf(rotation_degrees.y, 0, 360), 1)
