@tool
extends Node3D
class_name TextElement

@onready var text_label: MeshInstance3D = $Text
@onready var text_shadow_label: MeshInstance3D = $TextShadow

var _text: String
@export var text: String:
	get:
		return _text
	set(value):
		_text = value
		if text_label and text_shadow_label:
			_set_mesh_text(text_label.mesh)
			_set_mesh_text(text_shadow_label.mesh)

func _set_mesh_text(mesh: Mesh) -> void:
	if (mesh is not TextMesh):
		return
		
	var plane = mesh as TextMesh
	plane.text = _text

func _ready() -> void:
	text_label.mesh = text_label.mesh.duplicate()
	text_shadow_label.mesh = text_shadow_label.mesh.duplicate()
	_set_mesh_text(text_label.mesh)
	_set_mesh_text(text_shadow_label.mesh)
