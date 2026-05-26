class_name InteractionTarget
extends ActionTarget

@export var interactable_text: String

signal interacted

func interact() -> void:
	interacted.emit()
