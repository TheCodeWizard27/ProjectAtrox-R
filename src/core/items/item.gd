class_name Item

enum ItemType { 
	MISC = 0, 
	CONSUMABLE = 1, 
	GEAR = 2 
}

var type: ItemType
var item: int
var count: int = 1

func _init(p_type: ItemType, p_item: int, p_count: int = 1):
	type = p_type
	item = p_item
	count = p_count

static func new_misc_item(p_item: MiscItems.Item, p_count: int = 1) -> Item:
	return Item.new(ItemType.MISC, p_item, p_count)

static func new_consumable_item(p_item: ConsumableItems.Item, p_count: int = 1) -> Item:
	return Item.new(ItemType.CONSUMABLE, p_item, p_count)

static func new_gear_item(p_item: GearItems.Item) -> Item:
	return Item.new(ItemType.GEAR, p_item)
