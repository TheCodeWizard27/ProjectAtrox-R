class_name AirborneState
extends PlayerState

var movement_processor: PlayerMovementProcessor
var lock_on_processor: PlayerLockOnProcessor

func init(current_player: Player) -> void:
	super.init(current_player)
	lock_on_processor = PlayerLockOnProcessor.new(current_player)
	movement_processor = PlayerMovementProcessor.new(current_player)

func physics_update(delta: float) -> void:
	model_animator.advance_falling_to(1, delta)
	
	if(body.is_on_floor()):
		transition_to(PlayerState.GROUNDED)
		return
		
	movement_processor.process_movement(delta)
	lock_on_processor.process_lock_on()
