class_name NetworkingEvents

signal host_lobby_requested(host_data: HostLobbyServerData)
func request_host_lobby(host_data: HostLobbyServerData) -> void:
	host_lobby_requested.emit(host_data)

signal lobby_server_started(instance: HostLobbyInstance)
func notify_lobby_server_started(processor: HostLobbyProcessor) -> void:
	lobby_server_started.emit(HostLobbyInstance.new(processor))

signal lobby_server_start_failed()
func notify_lobby_server_start_failed() -> void:
	lobby_server_start_failed.emit()

signal join_lobby_requested(join_data: JoinLobbyData)
func request_join_lobby(join_data: JoinLobbyData) -> void:
	join_lobby_requested.emit(join_data)

signal lobby_joined(instance: ClientLobbyInstance)
func notify_lobby_joined(processor: LobbyClientProcessor) -> void:
	lobby_joined.emit(ClientLobbyInstance.new(processor))

signal lobby_join_failed()
func notify_lobby_join_failed() -> void:
	lobby_join_failed.emit()

signal stop_network_request()
func request_stop_network() -> void:
	stop_network_request.emit()
