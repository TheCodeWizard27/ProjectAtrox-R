extends Node

var entity: EntityEvents = EntityEvents.new()
var enemy: EnemyEvents = EnemyEvents.new()
var player: PlayerEvents = PlayerEvents.new()

signal scene_change_requested(scene_path: String, data: Dictionary)
func request_scene_change(scene_path: String, data: Dictionary) -> void:
	scene_change_requested.emit(scene_path, data)

signal camera_change_requested(camera: Camera3D)
func request_camera_change(camera: Camera3D) -> void:
	camera_change_requested.emit(camera)

signal box_destroyed()
func notify_box_destruction() -> void:
	box_destroyed.emit()
