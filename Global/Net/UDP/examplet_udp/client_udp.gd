extends Node


var client = PacketPeerUDP.new()


func _ready():
	var err = client.connect_to_host("127.0.0.1", 8080)
	
	if err != OK:
		push_error("can not open client on port 8080")
		
		
	if client.is_connected_to_host():
		print("connect server sucesss")
	
	

func _process(delta):
	if client.get_available_packet_count() > 0:
		var packet = client.get_var()
		print(packet)
	
	handle_input()


func handle_input():
	if Input.is_action_just_pressed("ui_accept"):
		var p = {
			"name": self.name,
			"level": self.get_instance_id()
		}
		client.put_var(p)
