class_name TargetDetector
extends Node

@export var lock_on_ray: RayCast3D

var targets: Array[ActionTarget] = []
var current_target: ActionTarget = null

func find_lock_on_target() -> Node3D:
	# Get all collisions by sequentially adding them to the exception list
	var ray_collisions = RayUtils.get_all_ray_intersections(lock_on_ray)
	
	var closest_collider: Node3D
	var closest_angle = PI
	var camera_direction = -lock_on_ray.global_transform.basis.z
	
	# Get lock on target closest to ray.
	for collider in ray_collisions:
		if (collider is not Node3D):
			continue
			
		var node = collider as Node3D
		
		var node_direction = (node.global_position - lock_on_ray.global_position).normalized()
		
		var angle = camera_direction.angle_to(node_direction)
		
		if (angle < closest_angle):
			closest_collider = node
			closest_angle = angle
	
	return closest_collider

func _on_area_entered(node: Node3D) -> void:
	if (node is ActionTarget):
		targets.append(node)
	
func _on_area_exited(node: Node3D) -> void:
	if (node is ActionTarget):
		targets.erase(node)
