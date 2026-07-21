class_name Item

enum Type {
	CONSUMABLE,
	GEAR,
	MISC,
	UNIQUE
}

var type: Type
var id: int
var name: String
var description: String

func _init(p_id: int, p_type: Type, p_name: String, p_description: String):
	id = p_id
	type = p_type
	name = p_name
	description = p_description
