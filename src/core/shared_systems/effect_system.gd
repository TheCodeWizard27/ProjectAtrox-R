class_name EffectSystem

var entity: Entity
var effects: Array[EffectReference]
var next_effect_tick: float

signal effects_updated()

func configure(p_entity: Entity, p_effects: Array[EffectReference]) -> void:
	entity = p_entity
	effects = p_effects

func process_effects(delta: float) -> void:
	next_effect_tick -= delta
	
	_update_effect_duration(delta)
	
	if (next_effect_tick <= 0):
		_process_all_effects()
		next_effect_tick = 1.0 + next_effect_tick

func add_effect(effect_reference: EffectReference) -> void:
	var effect = EffectTable.get_effect(effect_reference.id)
	
	var existing_reference = ArrayUtil.first_or_default(effects, func(other_effect: EffectReference):
		return other_effect.id == effect_reference.id
		)
	
	if (existing_reference != null):
		_join_references(existing_reference, effect_reference, effect.behaviour)
	else:
		effects.append(effect_reference)
		
	effects_updated.emit()

func remove_effect(effect_reference: EffectReference) -> void:
	effects.erase(effect_reference)
	effects_updated.emit()

func _join_references(
	original_reference: EffectReference, 
	new_reference: EffectReference, 
	behaviour: Effect.JoinBehaviour):
		
	match(behaviour):
		Effect.JoinBehaviour.KEEP_SEPERATE:
			effects.append(new_reference)
		Effect.JoinBehaviour.STACK:
			original_reference.stack += new_reference.stack
		Effect.JoinBehaviour.RENEW:
			original_reference.duration = new_reference.duration

func _update_effect_duration(delta: float) -> void:
	for effect_reference in effects:
		if (effect_reference.is_permanent):
			continue
		
		effect_reference.duration -= delta
		
		if (effect_reference.duration <= 0):
			remove_effect(effect_reference)

func _process_all_effects() -> void:
	
	for effect_reference in effects:
		var effect = EffectTable.get_effect(effect_reference.id)
		
		effect.behaviour.process(entity)
