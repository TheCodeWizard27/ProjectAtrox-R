class_name ArrayUtil

static func first_or_default(array: Array, find_filter: Callable, default = null):
	var index = array.find_custom(find_filter)
	return array[index] if index >= 0 else default
