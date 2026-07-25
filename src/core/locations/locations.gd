class_name Locations

enum LocationEnum {
	HUB = 0,
	SUBWAY = 1,
	TEST = 2
}

static var location_table: Dictionary[Locations.LocationEnum, Location] = {
	LocationEnum.HUB: Location.new("Hub", "res://src/scenes/areas/hub_area/hub_area.tscn"),
	LocationEnum.SUBWAY: Location.new("Subway", "res://src/scenes/areas/subway_area/subway_area.tscn"),
	LocationEnum.TEST: Location.new("Test", "res://src/scenes/areas/test_area/test_area.tscn")
}
