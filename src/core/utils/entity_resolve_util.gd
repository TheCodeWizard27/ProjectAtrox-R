class_name EntityResolveUtil

static func resolve_entity(node: Node) -> Entity:
	var scene_root = node.owner
	
	if('entity' in scene_root.get_groups() and scene_root is Entity):
		return scene_root
		
	return null
	
static func resolve_player(node: Node) -> Player:
	var scene_root = node.owner
	
	if('player' in scene_root.get_groups() and scene_root is Player):
		return scene_root
		
	return null

static func resolve_enemy(node: Node) -> Entity:
	var scene_root = node.owner
	
	if('enemy' in scene_root.get_groups() and scene_root is Enemy):
		return scene_root
		
	return null
