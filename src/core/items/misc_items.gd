class_name MiscItems

enum Item {
	TITANIUM = 0,
	CARBON = 1
}

static var item_table: Dictionary[MiscItems.Item, MiscItem] = {
	MiscItems.Item.TITANIUM: MiscItem.new('Titanium', 'A rare metal.'),
	MiscItems.Item.CARBON: MiscItem.new('Carbon', 'Cawbone.')
}
