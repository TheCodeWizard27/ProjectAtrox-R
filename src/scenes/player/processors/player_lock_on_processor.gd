class_name PlayerLockOnProcessor

var player: Player
var camera_controller: CameraController
var camera: Camera3D
var lock_on_ray: RayCast3D

func _init(current_player: Player):
	self.player = current_player
	self.camera_controller = current_player.camera_controller
	self.camera = current_player.camera
	self.lock_on_ray = current_player.lock_on_ray

func process_lock_on() -> void:
	if (Input.is_action_just_pressed("toggle_lock_on")):
		_toggle_lock_on()
	
	camera_controller.lock_on_target = player.lock_on_target

func _find_lock_on_target() -> Node3D:
	if (player.lock_on_target):
		return null
	
	# Get all collisions by sequentially adding them to the exception list
	var ray_collisions = RayUtils.get_all_ray_intersections(lock_on_ray)
	
	var closest_collider: Node3D
	# Just some high initial value so any angle wins
	var closest_angle = 1000
	
	# Get lock on target closest to ray.
	for collider in ray_collisions:
		if (collider is not Node3D):
			continue
			
		var node = collider as Node3D
		var angle = camera.global_position.angle_to(node.global_position)
		
		if (angle < closest_angle):
			closest_collider = node
			closest_angle = angle
	
	return closest_collider

func _toggle_lock_on() -> void:
	if (player.lock_on_target):
		player.lock_on_target = null
		return
	
	player.lock_on_target = _find_lock_on_target()
