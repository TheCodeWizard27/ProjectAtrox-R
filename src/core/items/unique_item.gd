class_name UniqueItem
extends Item

func _init(p_id: int, p_name: String, p_description: String):
	id = p_id
	type = Item.Type.UNIQUE
	name = p_name
	description = p_description
	stack_limit = 16
