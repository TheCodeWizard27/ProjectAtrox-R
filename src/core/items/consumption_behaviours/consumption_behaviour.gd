class_name ConsumptionBehaviour

var _callable: Callable = _do_nothing

static var do_nothing: ConsumptionBehaviour = new(_do_nothing)

#region Instance Creation Methods

static func heal(heal_amount: float) -> ConsumptionBehaviour:
	return new(_heal.bind(heal_amount))

#endregion

#region Callables

static func _do_nothing(_player: Player) -> void:
	pass

static func _heal(player: Player, heal_amount: float) -> void:
	player.status.resources.health += heal_amount
	print('Healing for ', heal_amount)

#endregion

func _init(consumption_function: Callable):
	_callable = consumption_function

func consume(player: Player) -> void:
	_callable.call(player)
