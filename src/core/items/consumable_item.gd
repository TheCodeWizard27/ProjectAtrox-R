class_name ConsumableItem
extends Item

var behaviour: ConsumptionBehaviour = ConsumptionBehaviour.do_nothing

func _init(p_id: ItemIds.Id, p_name: String, p_description: String):
	id = p_id
	type = Item.Type.CONSUMABLE
	name = p_name
	description = p_description
	stack_limit = 16
