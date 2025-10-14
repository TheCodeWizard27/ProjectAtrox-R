class_name PlayerAnimator
extends AnimationTree

enum {
	ATTACK_SLASH_VALUE = 0,
	ATTACK_STAB_VALUE = 1,
	ATTACK_SHOOT_VALUE = 2
}

var _attack_map = {
	ATTACK_SLASH_VALUE: "attack_melee_1",
	ATTACK_STAB_VALUE: "attack_melee_2",
	ATTACK_SHOOT_VALUE: "attack_ranged_1"
}

var _falling_blend_amount = "parameters/falling/blend_amount"
var _falling_blend_speed = 10
var _running_blend_position = "parameters/running/blend_position"
var _attack_request = "parameters/attack_one_shot/request"
var _attack_type = "parameters/attack/blend_position"
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

func play_attack(type: int) -> void:
	set(_attack_type, type)
	set(_attack_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func play_death() -> void:
	set(_dying_blend_amount, 1) # Only show death animation
	set(_dying_seek_request, 0) # Start animation

func _on_animation_finished(anim_name: StringName) -> void:
	var animation_matches_any_attack = _attack_map \
		.values() \
		.any(func(attack_animation): return attack_animation == anim_name)
	if(animation_matches_any_attack):
		on_attack_finished.emit()
