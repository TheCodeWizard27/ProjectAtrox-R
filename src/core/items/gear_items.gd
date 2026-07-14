class_name GearItems
enum Item {
	# Weapons
	NOVICE_WEAPON = 0,
	VETERAN_WEAPON = 1,
	HIGHTECH_WEAPON = 2,
	
	# Helmet Slot
	NOVICE_HELMET = 3,
	VETERAN_HELMET = 4,
	HIGHTECH_HELMET = 5,
	
	# Chest Slot
	NOVICE_BREASTPLATE = 6,
	VETERAN_BREASTPLATE = 7,
	HIGHTECH_BREASTPLATE = 8,
	
	# Leg Slot
	NOVICE_LEGS = 9,
	VETERAN_LEGS = 10,
	HIGHTECH_LEGS = 11
}

static var item_table: Dictionary[GearItems.Item, GearItem] = {
	# Weapons
	GearItems.Item.NOVICE_WEAPON: GearItem.new('Novice Weapon', ''),
	GearItems.Item.VETERAN_WEAPON: GearItem.new('Veteran Weapon', ''),
	GearItems.Item.HIGHTECH_WEAPON: GearItem.new('Hightech Weapon', ''),
	
	# Helmet Slot
	GearItems.Item.NOVICE_HELMET: GearItem.new('Novice Helmet', ''),
	GearItems.Item.VETERAN_HELMET: GearItem.new('Veteran Helmet', ''),
	GearItems.Item.HIGHTECH_HELMET: GearItem.new('Hightech Helmet', ''),
	
	# Chest Slot
	GearItems.Item.NOVICE_BREASTPLATE: GearItem.new('Novice Breastplate', ''),
	GearItems.Item.VETERAN_BREASTPLATE: GearItem.new('Veteran Breastplate', ''),
	GearItems.Item.HIGHTECH_BREASTPLATE: GearItem.new('Hightech Breastplate', ''),
	
	# Leg Slot
	GearItems.Item.NOVICE_LEGS: GearItem.new('Novice Legs', ''),
	GearItems.Item.VETERAN_LEGS: GearItem.new('Veteran Legs', ''),
	GearItems.Item.HIGHTECH_LEGS: GearItem.new('Hightech Legs', ''),
}
