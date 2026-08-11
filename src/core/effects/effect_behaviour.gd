class_name EffectBehaviour

var _processor: Callable = _do_nothing
var _attribute_processor: Callable = _change_nothing

static var do_nothing: EffectBehaviour = new(_do_nothing, _change_nothing)

#region Instance Creation Methods

static func regen(heal_amount: float) -> EffectBehaviour:
	return new(_regen.bind(heal_amount), _change_nothing)

static func increase_speed(flat_speed_increase: float) -> EffectBehaviour:
	return new(_do_nothing, _increase_speed.bind(flat_speed_increase))

#endregion

#region Effect Processors

static func _do_nothing(_entity: Entity) -> void:
	pass

static func _regen(entity: Entity, heal_amount: float) -> void:
	print(entity, entity is Player, heal_amount)
	if (entity is Player):
		_regen_player(entity, heal_amount)
	elif (entity is Enemy):
		_regen_enemy(entity, heal_amount)

static func _regen_player(player: Player, heal_amount: float) -> void:
	player.status.resources.health += heal_amount
	print('Healing for ', heal_amount)

static func _regen_enemy(enemy: Enemy, heal_amount: float) -> void:
	enemy.current_health += heal_amount

#endregion

#region Effect Attribute Procesors

static func _change_nothing(_attributes: EntityAttributes) -> void:
	pass

static func _increase_speed(attributes: EntityAttributes, increase_amount: float) -> void:
	attributes.speed.flat_modifier += increase_amount

#endregion

func _init(effect_function: Callable, attribute_function: Callable):
	_processor = effect_function
	_attribute_processor = attribute_function

func process(entity: Entity) -> void:
	_processor.call(entity)

func process_attribute(attributes: EntityAttributes) -> void:
	_attribute_processor.call(attributes)
