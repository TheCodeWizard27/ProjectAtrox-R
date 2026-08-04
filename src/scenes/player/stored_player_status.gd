class_name StoredPlayerStatus

var name: String = "Default"
var combat_class: Enums.CombatClasses = Enums.CombatClasses.WARRIOR
var play_time: float = 0
var currency: int = 0

# TODO implement quest list.
var current_quest: Quest

var inventory: Array[ItemReference] = [
	ItemReference.new(ItemIds.Id.HEAL_CRYSTAL),
	ItemReference.new(ItemIds.Id.TITANIUM, 2)
]
var gear_inventory: Array[ItemReference] = [
	ItemReference.new(ItemIds.Id.HIGH_TECH_WEAPON)
]

var weapon_slot: ItemReference = ItemReference.new(ItemIds.Id.NOVICE_WEAPON)
var head_slot: ItemReference = ItemReference.new(ItemIds.Id.NOVICE_HELMET)
var chest_slot: ItemReference = ItemReference.new(ItemIds.Id.NOVICE_BREASTPLATE)
var legs_slot: ItemReference = ItemReference.new(ItemIds.Id.NOVICE_LEGS)
