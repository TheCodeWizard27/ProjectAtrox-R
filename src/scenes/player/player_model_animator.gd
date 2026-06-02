class_name PlayerModelAnimator
extends AnimationTree

var warrior_animator := WarriorModelAnimator.new(
	self, _class_action_one_shot, _class_action_space_prefix, 0)

var _class_action_one_shot = "parameters/class_action_one_shot/request"
var _class_action_space_prefix = "parameters/class_action_space"

var _falling_blend_amount = "parameters/falling/blend_amount"
var _falling_blend_speed = 10
var _running_blend_position = "parameters/running/blend_position"
var _interact_request = "parameters/interact_one_shot/request"

func advance_falling_to(target_value: float, delta: float) -> void:
	var new_value = lerpf(get(_falling_blend_amount), target_value, delta * _falling_blend_speed)
	set(_falling_blend_amount, new_value)
	
func reset_falling_animation() -> void:
	set(_falling_blend_amount, 0)

func set_running(speed: float) -> void:
	set(_running_blend_position, speed)

func play_interact() -> void:
	set(_interact_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
