class_name PlayerStatus

var name: String = "Default"
var play_time: float = 0
var current_health: float = 10
var combat_class: Enums.CombatClasses = Enums.CombatClasses.WARRIOR
var base_attributes: PlayerAttributes = PlayerAttributes.new()
var attributes: PlayerAttributes = PlayerAttributes.new()
var currency: int = 0

var inventory: Array[Item] = [
	Item.new_consumable_item(ConsumableItems.Item.HEAL_CRYSTAL),
	Item.new_misc_item(MiscItems.Item.TITANIUM, 2)
]
var gear_inventory: Array[Item] = [
	Item.new_gear_item(GearItems.Item.HIGHTECH_WEAPON)
]

var weapon_slot: Item = Item.new_gear_item(GearItems.Item.NOVICE_WEAPON)
var head_slot: Item = Item.new_gear_item(GearItems.Item.NOVICE_HELMET)
var chest_slot: Item = Item.new_gear_item(GearItems.Item.NOVICE_BREASTPLATE)
var legs_slot: Item = Item.new_gear_item(GearItems.Item.NOVICE_LEGS)
