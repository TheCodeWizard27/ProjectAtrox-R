extends Node3D

# This code was adapted from the GUI in 3D Viewport Demo
# https://godotengine.org/asset-library/asset/2807

var _mouse_events = [
	InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch
]
var _is_mouse_inside = false
var _last_local_pos = null
var _last_event_time: float = -1.0

@onready var viewport = $SubViewport
@onready var screen = $Screen
@onready var area = $Screen/Area3D

func _ready() -> void:
	area.mouse_entered.connect(_mouse_entered_area)
	area.mouse_exited.connect(_mouse_exited_area)
	area.input_event.connect(_mouse_input_event)
	
func _mouse_entered_area() -> void:
	_is_mouse_inside = true
	
func _mouse_exited_area() -> void:
	_is_mouse_inside = false
	
func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	# Get mesh size to detect edges and make conversions. This code only support PlaneMesh and QuadMesh.
	var screen_size = screen.mesh.size

	# Current time in seconds since engine start.
	var now: float = Time.get_ticks_msec() / 1000.0

	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	var screen_pos = screen.global_transform.affine_inverse() * event_position

	var local_pos: Vector2 = Vector2()

	if _is_mouse_inside:
		# Convert the relative event position from 3D to 2D.
		local_pos = Vector2(screen_pos.x, -screen_pos.y)

		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		local_pos.x = local_pos.x / screen_size.x
		local_pos.y = local_pos.y / screen_size.y
		# Then we need to convert it into the following range: 0 -> 1
		local_pos.x += 0.5
		local_pos.y += 0.5

		# Finally, we convert the position to the following range: 0 -> viewport.size
		local_pos.x *= viewport.size.x
		local_pos.y *= viewport.size.y
		# We need to do these conversions so the event's position is in the viewport's coordinate system.

	elif _last_local_pos != null:
		# Fall back to the last known event position.
		local_pos = _last_local_pos

	# Set the event's position and global position.
	event.position = local_pos
	if event is InputEventMouse:
		event.global_position = local_pos

	# Calculate the relative event distance.
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion.
		if _last_local_pos == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# the previous position from the new position. This will give us the distance the event traveled from prev_pos.
		else:
			event.relative = local_pos - _last_local_pos
			event.velocity = event.relative / (now - _last_event_time)

	# Update last_event_pos2D with the position we just calculated.
	_last_local_pos = local_pos

	# Update last_event_time to current time.
	_last_event_time = now

	# Finally, send the processed input event to the viewport.
	viewport.push_input(event)
	
func _unhandled_input(event: InputEvent) -> void:
	for mouse_event in _mouse_events:
		if (is_instance_of(event, mouse_event)):
			return
			
	viewport.push_input(event)
	
