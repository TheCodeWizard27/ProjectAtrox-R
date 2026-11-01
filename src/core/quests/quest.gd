class_name Quest

var name: String
var description: String
var location: Locations.LocationEnum

func _init(p_name: String, p_description: String, p_location: Locations.LocationEnum):
	name = p_name
	description = p_description
	location = p_location
