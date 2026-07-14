class_name GearItem

enum GearSlot { WEAPON, HEAD, CHEST, LEGS }

var name: String
var description: String

var max_health_bonus: int = 100
var strength_bonus: int = 20
var dexterity_bonus: int = 20
var intelligence_bonus: int = 20
var defense_bonus: int = 20
var crit_chance_bonus: float = 0.1
var speed_bonus: float = 1.0

func _init(p_name: String, p_description: String):
	name = p_name
	description = p_description
