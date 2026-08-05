class_name Effect

enum JoinBehaviour {
	KEEP_SEPERATE = 0,
	STACK = 1,
	RENEW = 2
}

var id: EffectIds.Id = EffectIds.Id.UNKNOWN
var join_behaviour: JoinBehaviour = JoinBehaviour.RENEW
var name: String
var description: String

var behaviour: EffectBehaviour = EffectBehaviour.do_nothing

func _init(p_id: EffectIds.Id, p_join_behaviour: JoinBehaviour, p_name: String, p_description: String):
	id = p_id
	join_behaviour = p_join_behaviour
	name = p_name
	description = p_description
