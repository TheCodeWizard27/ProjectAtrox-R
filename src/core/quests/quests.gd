class_name Quests

enum QuestEnum {
	SUBWAY_SURF = 0,
	TESTORIAL = 1
}

static var quest_table: Dictionary[Quests.QuestEnum, Quest] = {
	QuestEnum.SUBWAY_SURF: Quest.new("Subway Surf", "You should surf on some subs", Locations.LocationEnum.SUBWAY),
	QuestEnum.TESTORIAL: Quest.new("Test Quest", "just a test of your reflexes", Locations.LocationEnum.TEST),
}
