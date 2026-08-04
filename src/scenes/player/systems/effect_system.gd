class_name EffectSystem

var player: Player
var next_effect_tick: float

signal effects_updated()

# TODO This also needs to be done for the enemy.

func process_effects(delta: float) -> void:
	next_effect_tick -= delta
	
	for effect_reference in player.status.effects:
		if (effect_reference.is_permanent):
			continue
		
		effect_reference.duration -= delta
		
		if (effect_reference.duration <= 0):
			remove_effect(effect_reference)
	
	if (next_effect_tick <= 0):
		_process_all_effects()
		next_effect_tick = 1.0 + next_effect_tick

func add_effect(effect_reference: EffectReference) -> void:
	# TODO make stacking possible
	player.status.effects.append(effect_reference)
	effects_updated.emit()

func remove_effect(effect_reference: EffectReference) -> void:
	player.status.effects.erase(effect_reference)
	effects_updated.emit()

func _process_all_effects() -> void:
	
	for effect_reference in player.status.effects:
		var effect = EffectTable.get_effect(effect_reference.id)
		
		effect.behaviour.process(player)
