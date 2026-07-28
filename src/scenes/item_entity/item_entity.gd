class_name ItemEntity
extends Entity

@onready var body: RigidBody3D = $RigidBody3D
@onready var collection_box: Area3D = $RigidBody3D/CollectionBox

var item_reference: ItemReference

func add_spawn_velocity() -> void:
	body.linear_velocity = Vector3.UP * 4
	var dir = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	body.linear_velocity.x = dir.x
	body.linear_velocity.z = dir.y

func delay_pick_up() -> void:
	collection_box.set_deferred('monitorable', false)
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): collection_box.set_deferred('monitorable', true))
	timer.start(0.5)

func pick_up() -> ItemReference:
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): queue_free())
	timer.start(0.5)
	
	collection_box.set_deferred('monitorable', false)

	return item_reference
