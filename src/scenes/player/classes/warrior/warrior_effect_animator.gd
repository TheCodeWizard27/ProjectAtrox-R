class_name WarriorEffectAnimator
extends PlayerEffectAnimator

enum PrimaryAttackSteps {
	STEP_1,
	STEP_2,
	STEP_3
}

var _primary_attack_step_1_one_shot_request = "parameters/primary_attack_step_1_one_shot/request"
var _primary_attack_step_2_one_shot_request = "parameters/primary_attack_step_2_one_shot/request"
var _primary_attack_step_3_one_shot_request = "parameters/primary_attack_step_3_one_shot/request"

func play_primary_effect(type: PrimaryAttackSteps) -> void:
	match(type):
		PrimaryAttackSteps.STEP_1:
			set(_primary_attack_step_1_one_shot_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		PrimaryAttackSteps.STEP_2:
			set(_primary_attack_step_2_one_shot_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		PrimaryAttackSteps.STEP_3:
			set(_primary_attack_step_3_one_shot_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
