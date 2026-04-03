extends Node
class_name PlaceholderNode

var _current_node: Node

func load_in(new_scene: PackedScene) -> Node:
	clear()
	_current_node = new_scene.instantiate()
	add_sibling(_current_node)
	return _current_node
	
func replace_in(node: Node) -> Node:
	clear()
	_current_node = node
	add_sibling(_current_node)
	return _current_node

func clear() -> void:
	print_debug('TestSpawn: Entering clear', _current_node)
	if (_current_node == null): return

	get_parent().remove_child(_current_node)
	print_debug('TestSpawn: removed child', _current_node)
	_current_node.queue_free()
	print_debug('TestSpawn: queue freed', _current_node)
	print_debug('test')
	_current_node = null
