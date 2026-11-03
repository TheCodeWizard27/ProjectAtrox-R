extends Node
class_name EntityManager

var _player_scene = preload('res://src/scenes/player/player.tscn')

func spawn_player(player_status: PlayerStatus, position: Vector3, rotation: Vector3) -> Player:
	var entity = _player_scene.instantiate() as Player
	entity.configure_player(player_status)
	spawn_entity(entity, position, rotation)
	
	return entity

func spawn_entity(entity: Entity, position: Vector3, rotation: Vector3) -> void:
	add_child(entity)
	entity.global_position = position
	entity.set_entity_rotation(rotation)

func spawn_item_entity(enemy: Enemy) -> void:
	var item = preload('res://src/scenes/item_entity/item_entity.tscn').instantiate() as ItemEntity
	Events.entity.spawn_entity(item, enemy.get_entity_position(), enemy.get_entity_rotation())
	item.item_reference = ItemReference.new(ItemIds.Id.CARBON)
	item.add_spawn_velocity()
