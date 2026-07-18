@tool
extends EditorImportPlugin

const delimiter_import_option = 'delimiter'
const has_header_import_option = 'has_header'

func _get_importer_name():
	return 'csv-data-importer'

func _get_visible_name():
	return 'CSV Data'

func _get_recognized_extensions():
	return ['csv', 'tsv']

func _get_preset_count() -> int:
	return 0

func _get_save_extension() -> String:
	return 'res'
	
func _get_resource_type() -> String:
	return 'Resource'
	
func _get_option_visibility(_path: String, _option_name: StringName, _options: Dictionary) -> bool:
	return true

func _get_import_options(_path: String, _preset_index: int) -> Array[Dictionary]:
	return [
		{ name = delimiter_import_option, default_value = ',' },
		{ name = has_header_import_option, default_value = true }
	]

func _import(
	source_file: String,
	save_path: String,
	options: Dictionary,
	_platform_variants: Array[String],
	_gen_files: Array[String]
	) -> Error:
	
	var delimiter = options.get(delimiter_import_option, ',')
	var has_header = options.get(has_header_import_option, true)
	
	var file = FileAccess.open(source_file, FileAccess.READ)
	
	if (file == null):
		return FileAccess.get_open_error()
	
	var headers: Array[String] = []
	var entries: Array[Dictionary] = []
	
	var line_number = 0
	
	if (has_header and not file.eof_reached()):
		line_number += 1
		var header_line = file.get_csv_line()
		
		for header in header_line:
			headers.append(header)
	
	while (not file.eof_reached()):
		var line = file.get_csv_line(delimiter)
		
		if (file.eof_reached() and (line.is_empty() or (line.size() == 1 and line[0] == ''))):
			continue
		
		if (headers and headers.size() != line.size()):
			print(line)
			printerr('Row column count doesn\'t match header on Line ', line_number)
			return ERR_PARSE_ERROR
		
		var entry: Dictionary = {}
		
		for column in range(0, line.size()):
			var key = headers[column] if has_header else str(column)
			entry[key] = _parse_value(line[column])
		
		entries.append(entry)
	
	file.close()
	
	var csv_data: CsvData = preload('res://addons/csv_importer/csv_data.gd').new()
	
	csv_data.headers = headers
	csv_data.entries = entries
	
	return ResourceSaver.save(csv_data, save_path + '.' + _get_save_extension())

func _parse_value(raw: String):
	if (raw.is_valid_int()):
		return int(raw)
	
	if (raw.is_valid_float()):
		return float(raw)
		
	if (raw.nocasecmp_to('false') == 0):
		return false
	
	if (raw.nocasecmp_to('true') == 0):
		return true
	
	if (raw.nocasecmp_to('null') == 0):
		return null
		
	return raw
