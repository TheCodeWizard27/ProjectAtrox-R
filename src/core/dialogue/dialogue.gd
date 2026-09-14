class_name Dialogue

var _source: String
var _parts: PackedStringArray
var _current_step: int = 0


func _init(source_enum: DialogueSource.DialogueSourceEnum) -> void:
	_source = tr(DialogueSource.dialogue_source_table.get(source_enum))
	_parts = _source.split("<end>")

func get_current_line() -> String:
	_current_step += 1
	return _parts.get(_current_step)
	
