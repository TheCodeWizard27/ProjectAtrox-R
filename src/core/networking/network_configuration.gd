class_name NetworkConfiguration

static var _instance: NetworkConfiguration

var _stun_host = 'stun.l.google.com'
var stun_host_ip: String
var stun_port = 19302

var web_socket_heartbeat_interval = 0.8

var hole_punch_max_attempts = 25
var hole_punch_message = 'ping'
var hole_punch_delay = 0.3

var multiplayer_port = 7777
var hub_server: String = '83.78.19.253:7213'

func _init():
	stun_host_ip = IP.resolve_hostname(_stun_host, IP.TYPE_IPV4)

static func get_current() -> NetworkConfiguration:
	if (_instance == null):
		_instance = new()
	
	return _instance
