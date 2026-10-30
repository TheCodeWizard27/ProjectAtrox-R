extends GridContainer
class_name FooterButtonComponent

signal reject_button_pressed()
signal accept_button_pressed()

func _on_reject_button_pressed() -> void:
	reject_button_pressed.emit()


func _on_accept_button_pressed() -> void:
	accept_button_pressed.emit()
