class_name ConsumableItems

enum Item {
	HEAL_CRYSTAL = 0, 
	ENERGY_DRINK = 1, 
	ELEMENTAL_INFUSION = 2, 
	HERB = 3, 
	POTION = 4, 
	THROWING_KNIFE = 5, 
	SHOCK_TRAP = 6
}

static var item_table: Dictionary[ConsumableItems.Item, ConsumableItem] = {
	ConsumableItems.Item.HEAL_CRYSTAL: ConsumableItem.new('Heal Crystal', ''),
	ConsumableItems.Item.ENERGY_DRINK: ConsumableItem.new('Energy Drink', ''),
	ConsumableItems.Item.ELEMENTAL_INFUSION: ConsumableItem.new('Elemental Infusion', ''),
	ConsumableItems.Item.HERB: ConsumableItem.new('Herb', ''),
	ConsumableItems.Item.POTION: ConsumableItem.new('Potion', ''),
	ConsumableItems.Item.THROWING_KNIFE: ConsumableItem.new('Throwing Knife', ''),
	ConsumableItems.Item.SHOCK_TRAP: ConsumableItem.new('Shock Trap', ''),
}
