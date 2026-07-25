@tool
extends EditorPlugin

var csv_data_importer: EditorImportPlugin

func _enter_tree() -> void:
	csv_data_importer = preload("res://addons/csv_importer/csv_data_importer_plugin.gd").new()
	add_import_plugin(csv_data_importer)

func _exit_tree() -> void:
	remove_import_plugin(csv_data_importer)
	csv_data_importer = null
