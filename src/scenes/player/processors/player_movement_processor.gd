class_name PlayerMovementProcessor

var player: Player
var camera_controller: CameraController
var body: CharacterBody3D

func _init(current_player: Player):
	self.player = current_player
	self.camera_controller = current_player.camera_controller
	self.body = current_player.body

func look_at(vector: Vector3) -> void:
	var previous_rotation = player.body.rotation
	player.body.look_at(vector)
	player.body.rotation = Vector3(previous_rotation.x, player.body.rotation.y, previous_rotation.z)

func process_movement(delta: float, speed_modifier: float = 1) -> void:
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_dir = move_dir.rotated(Vector3.UP, camera_controller.rotation.y).normalized()
	
	# Calculate velocity with separated y component.
	var y_velocity = body.velocity.y
	body.velocity = move_dir * player.max_speed * speed_modifier
	body.velocity.y = y_velocity - Globals.GRAVITY * delta
	
	if (speed_modifier <= 0):
		return
	
	# Rotate Character body	
	if (move_dir.length() > player.turn_threshold):
		var target_angle = Vector3.BACK.signed_angle_to(move_dir, Vector3.UP)
		body.rotation.y = lerp_angle(body.rotation.y, target_angle, delta * 10)
