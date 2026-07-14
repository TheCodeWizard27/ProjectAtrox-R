class_name UniqueItems

enum Item {
	KEY = 0,
}

static var item_table: Dictionary[UniqueItems.Item, UniqueItem] = {
	UniqueItems.Item.KEY: UniqueItem.new('Key', 'I wonder what it does...'),
}
