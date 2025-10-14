class_name Utils

static func call_when_ready(node: Node, callback: Callable) -> void:
	if(!node.is_node_ready()):
		await node.ready
		
	callback.call()
