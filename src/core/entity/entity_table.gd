class_name EntityTable

static var instance: EntityTable

var _entities: Dictionary[EntityIds.Id, String] = {}

static func setup_instance() -> void:
	if (instance != null):
		return
	
	instance = EntityTable.new()

static func get_entity_path(id: EntityIds.Id) -> String:
	return instance._entities.get(id)

func _init() -> void:
	_entities = {
		EntityIds.Id.ITEM: 'res://src/scenes/item_entity/item_entity.tscn',
		
		EntityIds.Id.BROOD: 'res://src/scenes/enemies/brood/brood_enemy.tscn',
		EntityIds.Id.BROOD_MOTHER: 'res://src/scenes/enemies/brood_mother/brood_mother_enemy.tscn'
	}
