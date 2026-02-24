class_name PlayerAnimator
extends AnimationTree

var _falling_blend_amount = "parameters/falling/blend_amount"
var _falling_blend_speed = 10
var _running_blend_position = "parameters/running/blend_position"
var _interact_request = "parameters/interact_one_shot/request"
var _attack_request = "parameters/attack_one_shot/request"
var _dying_blend_amount = "parameters/dying_blend/blend_amount"
var _dying_seek_request = "parameters/dying/seek_request"

signal on_attack_finished()

func play_particles() -> void:
	%Particles.emitting = true
	%Particles.restart()

func advance_falling_to(target_value: float, delta: float) -> void:
	var new_value = lerpf(get(_falling_blend_amount), target_value, delta * _falling_blend_speed)
	set(_falling_blend_amount, new_value)
	
func reset_falling_animation() -> void:
	set(_falling_blend_amount, 0)

func set_running(speed: float) -> void:
	set(_running_blend_position, speed)

func play_interact() -> void:
	set(_interact_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func play_attack() -> void:
	
	set(_attack_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func play_death() -> void:
	set(_dying_blend_amount, 1) # Only show death animation
	set(_dying_seek_request, 0) # Start animation
