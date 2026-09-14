class_name PlayerEvents

signal quest_accepted(quest: Quest)
func accept_quest(quest: Quest) -> void:
	quest_accepted.emit(quest)
	
signal dialogue_started(dialogue: Dialogue)
func start_dialogue(dialogue: Dialogue) -> void:
	dialogue_started.emit(dialogue)
