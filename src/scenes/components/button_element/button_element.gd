@tool
extends Node3D
class_name ButtonElement

@onready var label_element: LabelElement = $LabelElement
@onready var area: Area3D = $Area3D
@onready var area_collision_shape: CollisionShape3D = $Area3D/CollisionShape3D

var _text: String = "Text"
@export var text: String:
	get:
		return _text
	set(value):
		_text = value
		if label_element:
			label_element.text = value
			
var _size: Vector2 = Vector2(1.0, 0.2)
@export var size: Vector2:
	get:
		return _size
	set(value):
		_size = value
		if label_element and area:
			label_element.size = value
			_set_shape_size()

func _set_shape_size() -> void:
	if (!area_collision_shape):
		return
	
	if (area_collision_shape.shape is not BoxShape3D):
		return
		
	var box_shape = area_collision_shape.shape as BoxShape3D
	box_shape.size = Vector3(_size.x, _size.y, 0.1)
	area_collision_shape.position = Vector3(_size.x / 2, 0, 0)

func _ready() -> void:
	label_element.text = _text
	label_element.size = _size
	_set_shape_size()
	
	area.mouse_entered.connect(_mouse_entered_area)
	area.mouse_exited.connect(_mouse_exited_area)

func _mouse_entered_area() -> void:
	label_element.base_element.set_active()
	
func _mouse_exited_area() -> void:
	label_element.base_element.set_inactive()
