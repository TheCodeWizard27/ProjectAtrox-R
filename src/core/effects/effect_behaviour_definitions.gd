class_name EffectBehaviourDefinitions

static func get_mapped_behaviours() -> Dictionary[EffectIds.Id, EffectBehaviour]:
	var behaviour_map: Dictionary[EffectIds.Id, EffectBehaviour] = {
		EffectIds.Id.REGEN: EffectBehaviour.regen(5)
	}
	
	return behaviour_map
