@tool
extends Node3D
class_name LabelElement

@onready var text_element: TextElement = $Text
@onready var base_element: BaseElement = $Element

var _text: String = "Text"
@export var text: String:
	get:
		return _text
	set(value):
		_text = value
		if text_element:
			text_element.text = value
			
var _size: Vector2 = Vector2(1.0, 0.2)
@export var size: Vector2:
	get:
		return _size
	set(value):
		_size = value
		if base_element:
			base_element.size = value

func _ready() -> void:
	text_element.text = _text
	base_element.size = _size
