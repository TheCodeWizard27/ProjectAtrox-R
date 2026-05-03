class_name EntityResolveUtil

static func resolve_entity(node: Node) -> BaseEntity:
	var scene_root = node.owner
	
	if('entity' in scene_root.get_groups() and scene_root is BaseEntity):
		return scene_root
		
	return null
	
static func resolve_player(node: Node) -> Player:
	var scene_root = node.owner
	
	if('player' in scene_root.get_groups() and scene_root is Player):
		return scene_root
		
	return null

static func resolve_enemy(node: Node) -> BaseEntity:
	var scene_root = node.owner
	
	if('enemy' in scene_root.get_groups() and scene_root is BaseEnemy):
		return scene_root
		
	return null
