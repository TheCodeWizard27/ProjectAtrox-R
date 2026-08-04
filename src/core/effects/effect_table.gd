class_name EffectTable

static var instance: EffectTable

var _effects: Dictionary[EffectIds.Id, Effect] = {}

static func setup_instance() -> void:
	if (instance != null):
		return
	
	instance = EffectTable.new()

static func get_effect(id: EffectIds.Id) -> Effect:
	return instance._effects.get(id)

func _init() -> void:
	_load_effects()

func _load_effects() -> void:
	var effects: Array[Effect] = _load_effects_base(load('res://src/resources/data_tables/effects.csv'))
	_assign_effect_behaviour(effects, EffectBehaviourDefinitions.get_mapped_behaviours())
	
	for effect in effects:
		assert(not _effects.has(effect.id), 'Effect ' + str(effect.id) + ' already exists.')
		if (_effects.has(effect.id)):
			pass
		
		_effects.set(effect.id, effect)

func _assign_effect_behaviour(effects: Array[Effect], behaviours: Dictionary[EffectIds.Id, EffectBehaviour]) -> void:
	for effect_id in behaviours:
		var effect = ArrayUtil.first_or_default(effects, func(p_effect: Effect): return p_effect.id == effect_id)
		
		assert(effects != null, 'Cannot attach effect behaviour, effect ' + str(effect_id) + ' doesn\'t exist.')
		if(effects == null):
			continue
			
		effect.behaviour = behaviours[effect_id]

func _load_effects_base(csv_data: CsvData) -> Array[Effect]:
	var loaded_effects: Array[Effect] = []
	
	for item in csv_data.entries:
		loaded_effects.append(Effect.new(
			item.get('Id'),
			item.get('JoinBehaviour'),
			'Effect.' + item.get('Key') + '.Name',
			'Effect.' + item.get('Key') + '.Description'
		))
		
	return loaded_effects
