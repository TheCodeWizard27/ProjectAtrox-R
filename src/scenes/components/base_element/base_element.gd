@tool
extends Node3D
class_name BaseElement

@onready var background_mesh: MeshInstance3D = $Background
@onready var foreground_mesh: MeshInstance3D = $Foreground

var _size: Vector2 = Vector2(1, 0.2)
@export var size: Vector2:
	get:
		return _size
	set(value):
		_size = value
		if background_mesh and foreground_mesh:
			_set_plane_size(background_mesh.mesh)
			_set_plane_size(foreground_mesh.mesh)

func _set_plane_size(mesh: Mesh) -> void:
	if (mesh is not PlaneMesh):
		return
		
	var plane = background_mesh.mesh as PlaneMesh
	plane.size = size
	plane.center_offset = Vector3(size.x / 2, 0, 0)

func _ready() -> void:
	_set_plane_size(background_mesh.mesh)
	_set_plane_size(foreground_mesh.mesh)
