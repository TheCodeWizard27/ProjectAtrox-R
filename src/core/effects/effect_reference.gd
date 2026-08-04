class_name EffectReference

var id: EffectIds.Id = EffectIds.Id.UNKNOWN
var duration: float
var is_permanent: bool

func _init(p_id: EffectIds.Id, p_is_permanent: bool, p_duration: float):
	id = p_id
	is_permanent = p_is_permanent
	duration = p_duration

static func create_with_duration(p_id: EffectIds.Id, p_duration: float) -> EffectReference:
	return new(p_id, false, p_duration)

static func create_permanent(p_id: EffectIds.Id) -> EffectReference:
	return new(p_id, true, -1)
