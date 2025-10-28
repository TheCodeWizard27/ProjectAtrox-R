extends CombatClassController
class_name MageController

const mage_hud_path = "res://src/scenes/player/combat_classes/mage/mage_hud.tscn"

@onready var state_machine: StateMachine = %StateMachine
var hud: MageHud = preload(mage_hud_path).instantiate()

func init(current_player: Player) -> void:
	super.init(current_player)

	for state: PlayerState in state_machine.get_children():
		state.init(current_player)

func process(delta: float) -> void: # Needs to be manually called!
	state_machine.process(delta)
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	state_machine.physics_process(delta)
