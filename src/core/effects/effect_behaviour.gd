class_name EffectBehaviour

var _processor: Callable = _do_nothing

# TODO Effects should have both a processor and a attribute aggregation method?

static var do_nothing: EffectBehaviour = new(_do_nothing)

#region Instance Creation Methods

static func regen(heal_amount: float) -> EffectBehaviour:
	return new(_regen.bind(heal_amount))

#endregion

#region Callables

static func _do_nothing(_entity: Entity) -> void:
	pass

static func _regen(entity: Entity, heal_amount: float) -> void:
	print(entity, entity is Player, heal_amount)
	if (entity is Player):
		_regen_player(entity, heal_amount)
	elif (entity is Enemy):
		_regen_enemy(entity, heal_amount)

static func _regen_player(player: Player, heal_amount: float) -> void:
	player.status.current_health += heal_amount
	print('Healing for ', heal_amount)

static func _regen_enemy(enemy: Enemy, heal_amount: float) -> void:
	enemy.current_health += heal_amount

#endregion

func _init(effect_function: Callable):
	_processor = effect_function

func process(entity: Entity) -> void:
	_processor.call(entity)
