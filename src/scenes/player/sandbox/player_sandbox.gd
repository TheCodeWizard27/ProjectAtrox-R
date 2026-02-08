extends Node3D

@onready var player: Player = $Player

func _ready() -> void:
	var status = PlayerStatus.new()
	status.combat_class = Enums.CombatClasses.Warrior
	player.configure_player(status)
	Events.camera_change_requested.emit(player.camera)
