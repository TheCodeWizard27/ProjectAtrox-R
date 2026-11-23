class_name IpHelper

static func get_local_ip() -> String:
	var local_addresses = IP.get_local_addresses()
	local_addresses.reverse() # Reverse to prioritize later addresses if there are cached old ones.
	
	for address in local_addresses:
		if (not address.contains('.')):
			continue
		
		var segments = []
		for segment in address.split('.'):
			segments.push_back(int(segment))
			
		if (segments.size() < 1):
			continue
		
		#10.0.0.0 to 10.255.255.255
		if (segments[0] == 10):
			return address

		if (segments.size() < 2):
			continue

		# 172.16.0.0 to 172.31.255.255
		if (segments[0] == 172 &&
			segments[1] >= 16 && segments[1] <= 31):
			return address
		
		# 192.168.0.0 to 192.168.255.255 
		if (segments[0] == 192 && segments[1] == 168):
			return address
	
	return '127.0.0.1' # Should never occur but just return loopback for now.
