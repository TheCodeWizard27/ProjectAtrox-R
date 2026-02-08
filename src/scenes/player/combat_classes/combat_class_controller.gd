extends Node
class_name CombatClassController

var player: Player

func init(current_player: Player) -> void:
	player = current_player

func process(delta: float) -> void: # Needs to be manually called!
	pass
	
func physics_process(delta: float) -> void: # Needs to be manually called!
	pass
