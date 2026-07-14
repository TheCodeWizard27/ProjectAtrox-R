extends Node3D

@onready var interactable_area: Area3D = $InteractableArea
@export var is_exit: = true
signal activated

func _on_interacted() -> void:
	interactable_area.monitorable = false
	activated.emit()
	if(is_exit):
		Events.scene_change_requested.emit("res://src/scenes/areas/hub_area/hub_area.tscn", {})
	else:
		Events.scene_change_requested.emit("res://src/scenes/areas/subway_area/subway_area.tscn", {})		
