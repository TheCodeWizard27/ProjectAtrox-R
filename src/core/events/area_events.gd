class_name AreaEvents

signal area_change_requested(location: Locations.LocationEnum, data: Dictionary)
func request_area_change(location: Locations.LocationEnum, data: Dictionary) -> void:
	area_change_requested.emit(location, data)
