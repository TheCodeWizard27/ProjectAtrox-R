extends Entity

@export var hit_player: AnimationPlayer

func get_hit() -> void:
	super.get_hit()
	hit_player.play('hit')

func destroy() -> void:
	Events.box_destroyed.emit()
	queue_free()
