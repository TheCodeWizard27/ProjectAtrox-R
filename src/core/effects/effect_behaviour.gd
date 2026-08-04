class_name EffectBehaviour

var _processor: Callable = _do_nothing

# TODO Effects should have both a processor and a attribute aggregation method?

static var do_nothing: EffectBehaviour = new(_do_nothing)

#region Instance Creation Methods

static func regen(heal_amount: float) -> EffectBehaviour:
	return new(_regen.bind(heal_amount))

#endregion

#region Callables

static func _do_nothing(_player: Player) -> void:
	pass

static func _regen(player: Player, heal_amount: float) -> void:
	player.status.current_health += heal_amount
	print('Healing for ', heal_amount)

#endregion

func _init(effect_function: Callable):
	_processor = effect_function

func process(player: Player) -> void:
	_processor.call(player)
