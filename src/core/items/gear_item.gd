class_name GearItem
extends Item

enum GearSlot { WEAPON, HEAD, CHEST, LEGS }

var max_health_bonus: int = 0
var strength_bonus: int = 0
var dexterity_bonus: int = 0
var intelligence_bonus: int = 0
var defense_bonus: int = 1
var crit_chance_bonus: float = 0
var speed_bonus: float = 0

func _init(p_id: ItemIds.Id, p_name: String, p_description: String):
	id = p_id
	type = Item.Type.GEAR
	name = p_name
	description = p_description
	stack_limit = 1
