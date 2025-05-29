# client.gd
extends Node

var dtls := PacketPeerDTLS.new()
var udp := PacketPeerUDP.new()
var connected = false

func _ready():
	udp.connect_to_host("127.0.0.1", 4242)
	dtls.connect_to_peer(udp, false) # Use true in production for certificate validation!

func _process(delta):
	dtls.poll()
	if dtls.get_status() == PacketPeerDTLS.STATUS_CONNECTED:
		if !connected:
			# Try to contact server
			dtls.put_packet("The answer is... 42!".to_utf8())
		while dtls.get_available_packet_count() > 0:
			print("Connected: %s" % dtls.get_packet().get_string_from_utf8())
			connected = true