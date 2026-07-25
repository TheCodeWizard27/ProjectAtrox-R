class_name ItemTable

static var instance: ItemTable

var _items: Dictionary[int, Item] = {}

static func setup_instance() -> void:
	if (instance != null):
		return
	
	instance = ItemTable.new()

static func get_item(id: int) -> Item:
	return instance._items.get(id)

static func get_item_type(id: int) -> Item.Type:
	return instance._items.get(id).type

static func get_consumable_item(id: int) -> ConsumableItem:
	return instance._items.get(id) as ConsumableItem

static func get_gear_item(id: int) -> GearItem:
	return instance._items.get(id) as GearItem

static func get_misc_item(id: int) -> MiscItem:
	return instance._items.get(id) as MiscItem

static func get_unique_item(id: int) -> UniqueItem:
	return instance._items.get(id) as UniqueItem

func _init() -> void:
	_load_items()

func _load_items() -> void:
	var all_items: Array[Item]
	
	var consumable_items = _load_consumable_items(load('res://src/resources/data_tables/consumable_items.csv'))
	all_items.append_array(consumable_items)
	
	var gear_items = _load_gear_items(preload('res://src/resources/data_tables/gear_items.csv'))
	all_items.append_array(gear_items)
	
	var misc_items = _load_misc_items(preload('res://src/resources/data_tables/misc_items.csv'))
	all_items.append_array(misc_items)
	
	var unique_items = _load_unique_items(preload('res://src/resources/data_tables/unique_items.csv'))
	all_items.append_array(unique_items)
	
	for item in all_items:
		assert(not _items.has(item.id), 'Item ' + str(item.id) + ' already exists.')
		if (_items.has(item.id)):
			pass
		
		_items.set(item.id, item)

func _load_consumable_items(csv_data: CsvData) -> Array[ConsumableItem]:
	var loaded_items: Array[ConsumableItem] = []
	
	for item in csv_data.entries:
		loaded_items.append(ConsumableItem.new(
			item.get('Id'),
			'Item.' + item.get('Key') + '.Name',
			'Item.' + item.get('Key') + '.Description'
		))
		
	return loaded_items

func _load_gear_items(csv_data: CsvData) -> Array[GearItem]:
	var loaded_items: Array[GearItem] = []
	
	for item in csv_data.entries:
		loaded_items.append(GearItem.new(
			item.get('Id'),
			'Item.' + item.get('Key') + '.Name',
			'Item.' + item.get('Key') + '.Description'
		))
		
	return loaded_items
	
func _load_misc_items(csv_data: CsvData) -> Array[MiscItem]:
	var loaded_items: Array[MiscItem] = []
	
	for item in csv_data.entries:
		loaded_items.append(MiscItem.new(
			item.get('Id'),
			'Item.' + item.get('Key') + '.Name',
			'Item.' + item.get('Key') + '.Description'
		))
		
	return loaded_items
	
func _load_unique_items(csv_data: CsvData) -> Array[UniqueItem]:
	var loaded_items: Array[UniqueItem] = []
	
	for item in csv_data.entries:
		loaded_items.append(UniqueItem.new(
			item.get('Id'),
			'Item.' + item.get('Key') + '.Name',
			'Item.' + item.get('Key') + '.Description'
		))
		
	return loaded_items
