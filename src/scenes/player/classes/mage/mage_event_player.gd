
class_name MageEventPlayer
extends Node

enum PrimaryAttackSteps {
	STEP_1,
	STEP_2,
	STEP_3
}

@export var primary_attack_step_1_animator: AnimationPlayer
@export var primary_attack_step_2_animator: AnimationPlayer
@export var primary_attack_step_3_animator: AnimationPlayer

var _primary_attack_step_1 = "primary_attack_step_1"
var _primary_attack_step_2 = "primary_attack_step_2"
var _primary_attack_step_3 = "primary_attack_step_3"

func play_primary_effect(type: PrimaryAttackSteps) -> void:
	match(type):
		PrimaryAttackSteps.STEP_1:
			primary_attack_step_1_animator.play(_primary_attack_step_1)
		PrimaryAttackSteps.STEP_2:
			primary_attack_step_2_animator.play(_primary_attack_step_2)
		PrimaryAttackSteps.STEP_3:
			primary_attack_step_3_animator.play(_primary_attack_step_3)
