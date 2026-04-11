
class_name PlayerEventPlayer
extends Node

@export var hit_animator: AnimationPlayer

func play_getting_hit() -> void:
	hit_animator.play('hit')
