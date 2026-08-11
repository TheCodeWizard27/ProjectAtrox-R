class_name EntityAttribute

var base_value: float
var flat_modifier: float
var modifier: float = 1.0
var min_value: float
var max_value: float

var value: float:
	get:
		return min(max_value, max(min_value, (base_value + flat_modifier) * modifier))

func _init(p_base_value: float, p_min_value: float = 0, p_max_value: float = 999_999):
	base_value = p_base_value
	min_value = p_min_value
	max_value = p_max_value

func copy_without_modifiers() -> EntityAttribute:
	return EntityAttribute.new(base_value, min_value, max_value)
