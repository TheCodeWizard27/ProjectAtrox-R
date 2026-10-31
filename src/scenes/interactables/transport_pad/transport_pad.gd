extends Node3D

@onready var interactable_area: Area3D = $InteractableArea
@export var is_exit: = true
signal activated

func _on_interacted(player: Player, _arg: Dictionary) -> void:
	if(is_exit):
		Events.area.request_area_change(Locations.location_table.get(Locations.LocationEnum.HUB).path, {})
		return

	if(player.status.current_quest):
		interactable_area.monitorable = false
		activated.emit()
		Events.area.request_area_change(player.status.current_quest.location.path, {})
		return
