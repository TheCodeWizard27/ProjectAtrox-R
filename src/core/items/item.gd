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
var stack_limit: int

func _init(p_id: int, p_type: Type, p_name: String, p_description: String, p_stack_limit: int):
	id = p_id
	type = p_type
	name = p_name
	description = p_description
	stack_limit = p_stack_limit
