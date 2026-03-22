extends CombatClassController
class_name RangerController

const ranger_hud_path = "res://src/scenes/player/combat_classes/ranger/ranger_hud.tscn"

@onready var state_machine: StateMachine = %StateMachine
var hud: RangerHud = preload(ranger_hud_path).instantiate()

func init(current_player: Player) -> void:
	super.init(current_player)

	for state: RangerState in state_machine.get_children():
		state.init(current_player, self)

func process(delta: float) -> void: # Needs to be manually called!
	state_machine.process(delta)
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	state_machine.physics_process(delta)
