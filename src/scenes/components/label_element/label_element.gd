@tool
extends Node3D

@onready var text_element: TextElement = $Text

var _text: String
@export var text: String:
	get:
		return _text
	set(value):
		_text = value
		if text_element:
			text_element.text = value

func _ready() -> void:
	text_element.text = _text
