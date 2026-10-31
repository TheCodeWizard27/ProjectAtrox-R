class_name AreaEvents

signal area_change_requested(area_scene_path: String, data: Dictionary)
func request_area_change(area_scene_path: String, data: Dictionary) -> void:
	area_change_requested.emit(area_scene_path, data)
