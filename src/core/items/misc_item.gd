class_name MiscItem
extends Item

func _init(p_id: int, p_name: String, p_description: String):
	id = p_id
	type = Item.Type.MISC
	name = p_name
	description = p_description
