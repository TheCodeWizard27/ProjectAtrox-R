
class_name PlayerEventPlayer
extends Node

@export var warrior_event_player: WarriorEventPlayer

@export var hit_animator: AnimationPlayer

func play_getting_hit() -> void:
	hit_animator.play('hit')
