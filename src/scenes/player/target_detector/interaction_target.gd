class_name InteractionTarget
extends ActionTarget

@export var interactable_text: String

signal interacted(player: Player, arg: Dictionary)

func interact(player: Player, arg: Dictionary) -> void:
	interacted.emit(player, arg)
