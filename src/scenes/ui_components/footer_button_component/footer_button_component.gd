extends GridContainer
class_name FooterButtonComponent

@export var hide_reject_button: bool
@export var hide_accept_button: bool
@export var reject_string: String
@export var accept_string: String

@onready var reject_button: Button = $RejectMargin/RejectButton
@onready var accept_button: Button = $AcceptMargin/AcceptButton 

func _ready() -> void:
	if(hide_reject_button):
		reject_button.visible = false
	if(hide_accept_button):
		accept_button.visible = false
	reject_button.text = reject_string
	accept_button.text = accept_string

signal reject_button_pressed()
signal accept_button_pressed()

func _on_reject_button_pressed() -> void:
	reject_button_pressed.emit()


func _on_accept_button_pressed() -> void:
	accept_button_pressed.emit()
