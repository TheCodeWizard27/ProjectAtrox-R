extends State
class_name LobbyState

const MAIN_MENU: NodePath = ^'MainMenu'
const CREATE_LOBBY: NodePath = ^'CreateLobby'
const SELECT_LOBBY: NodePath = ^'SelectLobby'
const CONFIGURE_HUB: NodePath = ^'ConfigureHub'

var menu_path_dictonary = {
	Enums.LobbyMenuScreens.MAIN_MENU : MAIN_MENU,
	Enums.LobbyMenuScreens.CREATE_LOBBY : CREATE_LOBBY,
	Enums.LobbyMenuScreens.SELECT_LOBBY : SELECT_LOBBY,
	Enums.LobbyMenuScreens.CONFIGURE_HUB : CONFIGURE_HUB
}

var transition_state_result: StateResult = StateResult.continue_result

var _menu_control: LobbyControl

func init_for_control(menu_control: LobbyControl):
	_menu_control = menu_control

func enter(_msg: Dictionary = {}) -> void:
	_menu_control.visible = true
	
func exit() -> void:
	transition_state_result = StateResult.continue_result
	_menu_control.visible = false

func update(_delta: float) -> StateResult:
	if (transition_state_result != StateResult.continue_result):
		return transition_state_result
	return StateResult.continue_result

func set_transition_result(menuEnum: Enums.LobbyMenuScreens) -> void:
	transition_state_result = StateResult.transition_to(menu_path_dictonary.get(menuEnum))

func get_address() -> AddressInfo:
	var configuration = NetworkConfiguration.get_current()
	var stun_request = StunRequest.new(configuration.stun_host_ip, configuration.stun_port)
	add_child(stun_request)
	
	var result = await stun_request.request_for_port(configuration.multiplayer_port)
	if (result != OK):
		push_error(result)
		stun_request.queue_free()
		return null
	
	var response = await stun_request.resolved
	
	stun_request.queue_free()
	var public_ip = response[StunRequest.RESULT_ADDRESS]
	var public_port = response[StunRequest.RESULT_PORT]
	
	var local_ip = IpHelper.get_local_ip()
	return AddressInfo.new(public_ip, public_port, local_ip, configuration.multiplayer_port)
