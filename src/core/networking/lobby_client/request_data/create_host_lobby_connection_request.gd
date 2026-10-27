class_name CreateJoinLobbyConnectionRequest

var lobby_id: String
var password: String
var address_info: AddressInfo

func _init(p_lobby_id: String, p_password: String, p_address_info: AddressInfo):
	lobby_id = p_lobby_id
	password = p_password
	address_info = p_address_info
