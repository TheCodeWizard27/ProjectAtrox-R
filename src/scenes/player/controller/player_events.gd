class_name PlayerEvents

signal quest_accepted(quest: Quest)
func accept_quest(quest: Quest) -> void:
	quest_accepted.emit(quest)
