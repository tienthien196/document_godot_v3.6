# server.gd
extends Node

var dtls := DTLSServer.new()
var server := UDPServer.new()
var peers = []

func _ready():
	server.listen(4242)
	var key = load("key.key") # Your private key.
	var cert = load("cert.crt") # Your X509 certificate.
	dtls.setup(key, cert)

func _process(delta):
	while server.is_connection_available():
		var peer : PacketPeerUDP = server.take_connection()
		var dtls_peer : PacketPeerDTLS = dtls.take_connection(peer)
		if dtls_peer.get_status() != PacketPeerDTLS.STATUS_HANDSHAKING:
			continue # It is normal that 50% of the connections fails due to cookie exchange.
		print("Peer connected!")
		peers.append(dtls_peer)
	for p in peers:
		p.poll() # Must poll to update the state.
		if p.get_status() == PacketPeerDTLS.STATUS_CONNECTED:
			while p.get_available_packet_count() > 0:
				print("Received message from client: %s" % p.get_packet().get_string_from_utf8())
				p.put_packet("Hello DTLS client".to_utf8())