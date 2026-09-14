extends Node3D

@onready var interactable_area: Area3D = $InteractableArea

var dialogueEnum = DialogueSource.DialogueSourceEnum.TEST_DIALOGUE

func _on_interacted(_player: Player, _arg: Dictionary) -> void:
	interactable_area.monitorable = false	
	Events.player.start_dialogue(Dialogue.new(dialogueEnum))
