class_name EffectBehaviourDefinitions

static func get_mapped_behaviours() -> Dictionary[EffectIds.Id, EffectBehaviour]:
	var behaviour_map: Dictionary[EffectIds.Id, EffectBehaviour] = {
		EffectIds.Id.REGEN: EffectBehaviour.regen(5),
		EffectIds.Id.SPEED: EffectBehaviour.increase_speed(1)
	}
	
	return behaviour_map
