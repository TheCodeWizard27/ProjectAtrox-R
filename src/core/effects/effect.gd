class_name Effect

var id: EffectIds.Id = EffectIds.Id.UNKNOWN
var name: String
var description: String

var behaviour: EffectBehaviour = EffectBehaviour.do_nothing

func _init(p_id: EffectIds.Id, p_name: String, p_description: String):
	id = p_id
	name = p_name
	description = p_description
