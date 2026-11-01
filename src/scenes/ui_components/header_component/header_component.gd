extends GridContainer
class_name HeaderComponent

@export var hide_home_button: bool
@export var current_menu_string: String

@onready var home_button: Button = $HomeMargin/HomeButton
@onready var current_menu_button: Button = $CurrentMenuMargin/CurrentMenuButton 

func _ready() -> void:
	if(hide_home_button):
		home_button.visible = false
	current_menu_button.text = current_menu_string

signal home_button_pressed()

func _on_home_button_pressed() -> void:
	home_button_pressed.emit()
