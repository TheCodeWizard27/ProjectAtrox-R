extends Control
class_name LobbyControl

signal lobby_menu_change_screen(menuEnum: Enums.LobbyMenuScreens) 

func navigation_action(menuEnum: Enums.LobbyMenuScreens) -> void:
	lobby_menu_change_screen.emit(menuEnum)
