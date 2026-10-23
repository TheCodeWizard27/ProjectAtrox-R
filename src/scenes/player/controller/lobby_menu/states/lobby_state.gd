extends State
class_name LobbyState

const LOBBY_MENU: NodePath = ^'LobbyMenu'
const CREATE_LOBBY: NodePath = ^'CreateLobby'
const SELECT_LOBBY: NodePath = ^'SelectLobby'
const CONFIGURE_HUB: NodePath = ^'ConfigureHub'

var menu_path_dictonary = {
	Enums.LobbyMenuScreens.LOBBY_MENU : LOBBY_MENU,
	Enums.LobbyMenuScreens.CREATE_LOBBY : CREATE_LOBBY,
	Enums.LobbyMenuScreens.SELECT_LOBBY : SELECT_LOBBY,
	Enums.LobbyMenuScreens.CONFIGURE_HUB : CONFIGURE_HUB
}

var transition_state_result: StateResult = StateResult.continue_result

@export var menu_control: LobbyControl

func enter(_msg: Dictionary = {}) -> void:
	menu_control.visible = true
	
func exit() -> void:
	transition_state_result = StateResult.continue_result
	menu_control.visible = false

func update(_delta: float) -> StateResult:
	if (transition_state_result != StateResult.continue_result):
		return transition_state_result
	return StateResult.continue_result

func set_transition_result(menuEnum: Enums.LobbyMenuScreens) -> void:
	transition_state_result = StateResult.transition_to(menu_path_dictonary.get(menuEnum))
	
