extends Node

@warning_ignore("unused_signal")
signal scene_change_requested(scene_path: String, data: Dictionary)

@warning_ignore("unused_signal")
signal camera_change_requested(camera: Camera3D)

@warning_ignore("unused_signal")
signal spawn_entity(entity: Entity, position: Vector3, rotation: Vector3)

@warning_ignore("unused_signal")
signal box_destroyed()
