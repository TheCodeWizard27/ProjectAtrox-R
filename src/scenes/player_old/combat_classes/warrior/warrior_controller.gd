extends CombatClassController
class_name WarriorController

const warrior_hud_path = "res://src/scenes/player/combat_classes/warrior/warrior_hud.tscn"

@onready var state_machine: StateMachine = %StateMachine
@onready var animator: PlayerAnimator = %PlayerAnimator
var hud: WarriorHud = preload(warrior_hud_path).instantiate()

func init(current_player: Player) -> void:
	super.init(current_player)

	for state: WarriorState in state_machine.get_children():
		state.init(current_player, self)

func process(delta: float) -> void: # Needs to be manually called!
	state_machine.process(delta)
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	state_machine.physics_process(delta)
