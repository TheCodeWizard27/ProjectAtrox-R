class_name ItemSpawner
extends EntitySpawner

var _item_scene = preload('res://src/scenes/item_entity/item_entity.tscn')

@export var item_type: ItemIds.Id = ItemIds.Id.HEAL_CRYSTAL
@export var item_count: int = 1

func spawn() -> Entity:
	var entity = _spawn_scene(_item_scene) as ItemEntity
	entity.item_reference = ItemReference.new(item_type, item_count)

	return entity
