class_name CardControlComponent
extends PanelContainer

@onready var label = $MarginContainer/LobbyConfigContainer/LobbyNameContainer/Label
@onready var player_count = $MarginContainer/LobbyConfigContainer/LobbyNameContainer/PlayerCountLabel
@onready var private_icon = $MarginContainer/LobbyConfigContainer/LobbyNameContainer/PrivateIcon


signal clicked

func set_entry(lobby: LobbyListEntry) -> void:
	label.text = lobby.name
	player_count.text = str(lobby.player_count) + ' / 4'
	private_icon.visible = lobby.is_private

func _on_clickable_area_pressed() -> void:
	clicked.emit()
