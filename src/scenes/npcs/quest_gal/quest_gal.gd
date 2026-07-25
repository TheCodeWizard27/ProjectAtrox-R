extends Node3D

@onready var interactable_area: Area3D = $InteractableArea

var quest = Quests.quest_table.get(Quests.QuestEnum.SUBWAY_SURF)

func _on_interacted(_player: Player, _arg: Dictionary) -> void:
	interactable_area.monitorable = false	
	Events.player.accept_quest(quest)
	
