class_name PlayerEffectAnimator
extends AnimationTree

var _hit_request = "parameters/hit_one_shot/request"

func play_getting_hit() -> void:
	set(_hit_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
