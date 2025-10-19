@tool
extends Node3D
class_name BaseElement

@onready var background_mesh: MeshInstance3D = $Background
@onready var foreground_mesh: MeshInstance3D = $Foreground

const foreground_color: Vector4 = Vector4(0.38, 0.37, 0.33, 0.74)
const highlight_color: Vector4 = Vector4(3.123, 1.617, 0.0, 0.741)

var _size: Vector2 = Vector2(1, 0.2)
@export var size: Vector2:
	get:
		return _size
	set(value):
		_size = value
		if background_mesh and foreground_mesh:
			_set_plane_size(background_mesh.mesh)
			_set_plane_size(foreground_mesh.mesh)
			notify_property_list_changed()

func _set_plane_size(mesh: Mesh) -> void:
	if (mesh is not PlaneMesh):
		return
		
	var plane = mesh as PlaneMesh
	plane.size = _size
	plane.center_offset = Vector3(_size.x / 2, 0, 0)
	
func set_active() -> void:
	var mat = foreground_mesh.mesh.surface_get_material(0)
	mat.set("shader_parameter/scanlineThreshold", 0.2)
	mat.set("shader_parameter/color", highlight_color)
	
func set_inactive() -> void:
	var mat = foreground_mesh.mesh.surface_get_material(0)
	mat.set("shader_parameter/scanlineThreshold", 0.0)
	mat.set("shader_parameter/color", foreground_color)

func _ready() -> void:
	background_mesh.mesh = background_mesh.mesh.duplicate(true)
	foreground_mesh.mesh = foreground_mesh.mesh.duplicate(true)
	_set_plane_size(background_mesh.mesh)
	_set_plane_size(foreground_mesh.mesh)
	set_inactive()
