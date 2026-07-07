class_name ConsumableItem

var name: String
var description: String

func _init(p_name: String, p_description: String):
	name = p_name
	description = p_description

func consume(_player: Player) -> void:
	pass
