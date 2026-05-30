extends Node3D

@onready var interactable_area: Area3D = $InteractableArea

signal activated

func _on_interacted() -> void:
	interactable_area.monitorable = false
	activated.emit()
