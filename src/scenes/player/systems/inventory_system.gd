class_name InventorySystem

var player_status: PlayerStatus

signal inventory_updated()

func configure(p_player_status: PlayerStatus) -> void:
	player_status = p_player_status

# Returns either null or ItemReference with what could not be added to the inventory.
func add_item(item: ItemReference) -> ItemReference:
	var type = ItemTable.get_item_type(item.id)
	
	if (type == Item.Type.GEAR):
		return _add_or_increase(
			item, 
			player_status.gear_inventory,
			player_status.attributes.gear_inventory_size
			)
	
	return _add_or_increase(
		item, 
		player_status.inventory,
		player_status.attributes.inventory_size
		)

# Returns either null or ItemReference with count of what was removed
func remove_item(item: ItemReference) -> ItemReference:
	var type = ItemTable.get_item_type(item.id)
	
	if (type == Item.Type.GEAR):
		return _remove_or_decrease(
			item, 
			player_status.gear_inventory
			)
	
	return _remove_or_decrease(
		item, 
		player_status.inventory
		)

func has_item(item: ItemReference) -> bool:
	var type = ItemTable.get_item_type(item.id)
	
	if (type == Item.Type.GEAR):
		return _has(
			item.id, 
			player_status.gear_inventory
			)
	
	return _has(
		item.id, 
		player_status.inventory
		)

func count_item(item: ItemReference) -> int:
	var type = ItemTable.get_item_type(item.id)
	
	if (type == Item.Type.GEAR):
		return _count(
			item.id, 
			player_status.gear_inventory
			)
	
	return _count(
		item.id, 
		player_status.inventory
		)

func _add_or_increase(item: ItemReference, inventory: Array[ItemReference], inventory_size: int) -> ItemReference:
	var stack_limit = ItemTable.get_item(item.id).stack_limit
	var item_count = item.count
	
	while (item_count > 0):
		# Increase stack size first before adding new inventory entries.
		var open_stacks: Array[ItemReference] = inventory.filter(func (existing_item: ItemReference):
			return existing_item.id == item.id and existing_item.count < stack_limit
			)
		
		if (open_stacks.size() > 0):
			var open_stack: ItemReference = open_stacks[0]
			var open_count = stack_limit - open_stack.count
			
			var resolved_count = min(item_count, open_count)
			item_count -= resolved_count
			open_stack.count += resolved_count
			inventory_updated.emit()
			continue
		
		if (inventory.size() < inventory_size):
			var resolved_count = min(item_count, stack_limit)
			item_count -= resolved_count
			inventory.append(ItemReference.new(item.id, resolved_count))
			inventory_updated.emit()
			continue
		
		# If there is no open stack or any inventory space left, return the rest.
		return ItemReference.new(item.id, item_count)
	
	return null

func _remove_or_decrease(item: ItemReference, inventory: Array[ItemReference]) -> ItemReference:
	var removed_count = 0
	var item_count = item.count
	
	while (item_count > removed_count):
		var stacks: Array[ItemReference] = inventory.filter(func (existing_item: ItemReference):
			return existing_item.id == item.id
			)
		
		if (stacks.size() <= 0):
			return ItemReference.new(item.id, removed_count)
		
		var stack: ItemReference = stacks[0]
		var resolved_count = min(stack.count, item_count - removed_count)
		removed_count += resolved_count
		stack.count -= resolved_count
		inventory_updated.emit()
	
	return ItemReference.new(item.id, item_count)

func _has(id: ItemIds.Id, inventory: Array[ItemReference]) -> bool:
	return inventory.any(func (item: ItemReference):
		return item.id == id
		)

func _count(id: ItemIds.Id, inventory: Array[ItemReference]) -> int:
	var matching_items: Array[ItemReference] = inventory.filter(func (item: ItemReference):
		return item.id == id
		)
	return matching_items.reduce(func (sum: int, item: ItemReference):
		return sum + item.count
		, 0)
