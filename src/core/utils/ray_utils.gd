class_name RayUtils

static func get_all_ray_intersections(ray: RayCast3D) -> Array:
	var collider_buffer = []
	while (ray.is_colliding()):
		var collider = ray.get_collider()
		collider_buffer.push_back(collider)
		ray.add_exception(collider)
		ray.force_raycast_update()
	ray.clear_exceptions()
	
	return collider_buffer
