extends Node
class_name PlaceholderNode

var _current_node: Node

func load_in(new_scene: PackedScene) -> Node:
	_current_node = new_scene.instantiate()
	add_sibling(_current_node)
	return _current_node

func clear() -> void:
	if (_current_node == null): return

	get_parent().remove_child(_current_node)
	_current_node.queue_free()
	_current_node = null
