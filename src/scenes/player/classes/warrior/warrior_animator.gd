
class_name WarriorAnimator
extends PlayerAnimator

enum PrimaryAttackBlendPositions {
	ATTACK1 = 0,
	ATTACK2 = 1,
	ATTACK3 = 2,
}

var _primary_attack_blend_position = "parameters/primary_attack/blend_position"
var _primary_attack_one_shot_request = "parameters/primary_attack_one_shot/request"

func play_primary_attack(type: PrimaryAttackBlendPositions) -> void:
	set(_primary_attack_blend_position, type)
	set(_primary_attack_one_shot_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
