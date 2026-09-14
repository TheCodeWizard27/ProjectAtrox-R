class_name DialogueSource

enum DialogueSourceEnum {
	TEST_DIALOGUE = 0,
}

static var dialogue_source_table: Dictionary[DialogueSource.DialogueSourceEnum, String] = {
	DialogueSourceEnum.TEST_DIALOGUE: "Dialogue.TestDialogue",
}
