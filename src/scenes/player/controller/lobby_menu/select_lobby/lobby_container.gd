class_name LobbyContainer
extends PanelContainer

@onready var label = $MarginContainer/LobbyNameContainer/Label
@onready var player_count = $MarginContainer/LobbyNameContainer/PlayerCountLabel

signal clicked

func set_entry(lobby: LobbyListEntry) -> void:
	label.text = lobby.name
	player_count.text = '1 / 4'

func _on_clickable_area_pressed() -> void:
	clicked.emit()
