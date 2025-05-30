extends Node
var udp = PacketPeerUDP.new()


func _ready():
	var err = udp.listen(8080)
	if err != OK:
		print("can not open port")
		return
	printerr("server listen on port 8080")


func _process(delta):
	if ! udp.is_listening():
		push_error("server close --------Error")
		
	if udp.get_available_packet_count() > 0:
		var data = udp.get_var()
		print("data", data)
		print("----info packet----")
		print("ip: %s || port : %s" % [udp.get_packet_ip(), udp.get_packet_port()])
		print("server receive packet")

