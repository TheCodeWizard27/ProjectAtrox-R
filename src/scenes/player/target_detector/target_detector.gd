extends Node
class_name TargetDetector

var interaction_target: InteractionTarget = null
var targets: Array[ActionTarget] = []
var current_target: ActionTarget = null

func _on_area_entered(node: Node3D) -> void:
	if (node is ActionTarget):
		targets.append(node)
		
	if (node is InteractionTarget):
		interaction_target = node
	
func _on_area_exited(node: Node3D) -> void:
	if (node is ActionTarget):
		targets.erase(node)
		
	if (node is InteractionTarget):
		interaction_target = null
