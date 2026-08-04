class_name ItemReference

var id: ItemIds.Id = ItemIds.Id.UNKNOWN
var count: int = 1

func _init(p_id: ItemIds.Id, p_count: int = 1):
	id = p_id
	count = p_count
