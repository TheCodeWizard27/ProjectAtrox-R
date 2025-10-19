@tool
extends Node3D
class_name TextElement

@onready var text_Label: Label3D = $Text
@onready var text_shadow_Label: Label3D = $TextShadow

var _text: String
@export var text: String:
	get:
		return _text
	set(value):
		_text = value
		if text_Label and text_shadow_Label:
			text_Label.text = value
			text_shadow_Label.text = value

func _ready() -> void:
	text_Label.text = _text
	text_shadow_Label.text = _text
