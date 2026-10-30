class_name CardControlComponent
extends PanelContainer

@onready var label = $MarginContainer/LobbyConfigContainer/LobbyNameContainer/Label
@onready var player_count = $MarginContainer/LobbyConfigContainer/LobbyNameContainer/PlayerCountLabel

signal clicked

func set_entry(lobby: LobbyListEntry) -> void:
	label.text = lobby.name
	player_count.text = '1 / 4'

func _on_clickable_area_pressed() -> void:
	clicked.emit()
