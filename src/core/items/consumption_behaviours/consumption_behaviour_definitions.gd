class_name ConsumptionBehaviourDefinitions

static func get_mapped_behaviours() -> Dictionary[ItemIds.Id, ConsumptionBehaviour]:
	var behaviour_map: Dictionary[ItemIds.Id, ConsumptionBehaviour] = {
		ItemIds.Id.HEAL_CRYSTAL: ConsumptionBehaviour.heal(25)
	}
	
	return behaviour_map
