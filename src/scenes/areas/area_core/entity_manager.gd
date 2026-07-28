extends Node
class_name EntityManager

func _init() -> void:
	Events.entity.entity_spawn_requested.connect(_on_spawn_entity)
	Events.enemy.died.connect(_on_enemy_death)
	
func _on_spawn_entity(entity: Entity, position: Vector3, rotation: Vector3) -> void:
	add_child(entity)
	entity.global_position = position
	entity.rotation = rotation

func _on_enemy_death(enemy: Enemy) -> void:
	var item = preload('res://src/scenes/item_entity/item_entity.tscn').instantiate() as ItemEntity
	Events.entity.spawn_entity(item, enemy.get_entity_position(), enemy.get_entity_rotation())
	item.item_reference = ItemReference.new(ItemIds.Id.CARBON)
	item.add_spawn_velocity()
