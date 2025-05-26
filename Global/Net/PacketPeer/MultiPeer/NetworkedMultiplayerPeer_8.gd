extends Node

# Biến để xác định vai trò server hay client
var is_server = false
var peer = NetworkedMultiplayerENet.new()
var server_port = 4242
var client_address = "127.0.0.1"
var max_players = 4

func _ready():
	# 1. Thiết lập thuộc tính kế thừa từ PacketPeer
	peer.set_allow_object_decoding(true)
	if peer.is_object_decoding_allowed():
		print("Cho phép giải mã object trong get_var/put_var.")
	else:
		print("Không cho phép giải mã object.")
	
	peer.set_encode_buffer_max_size(1048576) # 1MB
	if peer.get_encode_buffer_max_size() == 1048576:
		print("Kích thước buffer mã hóa được thiết lập thành 1MB.")
	else:
		print("Lỗi khi thiết lập kích thước buffer mã hóa.")
	
	# 2. Thiết lập thuộc tính của NetworkedMultiplayerPeer
	peer.set_refuse_new_connections(true)
	if peer.is_refusing_new_connections():
		print("Từ chối các kết nối mới.")
	peer.set_refuse_new_connections(false) # Bật lại để chấp nhận kết nối
	if not peer.is_refusing_new_connections():
		print("Cho phép các kết nối mới.")
	
	peer.set_transfer_mode(NetworkedMultiplayerPeer.TRANSFER_MODE_RELIABLE)
	if peer.get_transfer_mode() == NetworkedMultiplayerPeer.TRANSFER_MODE_RELIABLE:
		print("Chế độ truyền: RELIABLE")
	else:
		print("Lỗi khi thiết lập chế độ truyền.")
	
	# 3. Kết nối tín hiệu
	peer.connect("connection_succeeded", self, "_on_connection_succeeded")
	peer.connect("connection_failed", self, "_on_connection_failed")
	peer.connect("peer_connected", self, "_on_peer_connected")
	peer.connect("peer_disconnected", self, "_on_peer_disconnected")
	peer.connect("server_disconnected", self, "_on_server_disconnected")
	
	# 4. Quyết định vai trò server hay client
	is_server = OS.get_cmdline_args().has("--server")
	
	if is_server:
		# Thiết lập server
		var err = peer.create_server(server_port, max_players)
		if err == OK:
			print("Server được tạo trên port ", server_port)
			get_tree().network_peer = peer
		else:
			print("Lỗi khi tạo server: ", err)
			return
	else:
		# Thiết lập client
		var err = peer.create_client(client_address, server_port)
		if err == OK:
			print("Client kết nối tới ", client_address, ":", server_port)
			get_tree().network_peer = peer
		else:
			print("Lỗi khi tạo client: ", err)
			return
	
	# 5. Kiểm tra trạng thái kết nối
	var status = peer.get_connection_status()
	print("Trạng thái kết nối: ", get_connection_status_name(status))
	
	# 6. Lấy ID duy nhất
	var unique_id = peer.get_unique_id()
	print("ID duy nhất: ", unique_id)

func _process(delta):
	# 7. Poll để xử lý sự kiện mạng
	peer.poll()
	
	# 8. Kiểm tra trạng thái kết nối
	var status = peer.get_connection_status()
	if status == NetworkedMultiplayerPeer.CONNECTION_CONNECTED:
		if not is_server and not client_data_sent:
			# 9. Client: Gửi dữ liệu khi kết nối
			peer.set_target_peer(NetworkedMultiplayerPeer.TARGET_PEER_SERVER)
			var raw_data = "Hello, Server!".to_utf8()
			var err = peer.put_packet(raw_data)
			if err == OK:
				print("Client gửi gói tin thô tới server: ", raw_data.get_string_from_utf8())
			else:
				print("Lỗi khi gửi gói tin thô: ", err)
			
			var variant_data = {"message": "Hello from client", "value": 42}
			err = peer.put_var(variant_data, true)
			if err == OK:
				print("Client gửi dữ liệu Variant tới server: ", variant_data)
			else:
				print("Lỗi khi gửi dữ liệu Variant: ", err)
			client_data_sent = true
		
		# 10. Xử lý gói tin nhận được
		var packet_count = peer.get_available_packet_count()
		if packet_count > 0:
			print("Số gói tin có sẵn: ", packet_count)
			
			# 11. Nhận gói tin thô
			var packet = peer.get_packet()
			var packet_error = peer.get_packet_error()
			var packet_peer_id = peer.get_packet_peer()
			if packet_error == OK:
				print("Nhận gói tin thô từ peer ", packet_peer_id, ": ", packet.get_string_from_utf8())
			else:
				print("Lỗi khi nhận gói tin thô: ", packet_error)
			
			# 12. Nhận dữ liệu Variant
			var variant = peer.get_var(true)
			packet_error = peer.get_packet_error()
			if packet_error == OK:
				print("Nhận dữ liệu Variant từ peer ", packet_peer_id, ": ", variant)
			else:
				print("Lỗi khi nhận dữ liệu Variant: ", packet_error)
			
			# 13. Server: Phản hồi client
			if is_server:
				peer.set_target_peer(packet_peer_id) # Gửi lại cho peer gửi gói tin
				var response_data = "Hello, Client!".to_utf8()
				var err = peer.put_packet(response_data)
				if err == OK:
					print("Server gửi phản hồi thô tới peer ", packet_peer_id, ": ", response_data.get_string_from_utf8())
				else:
					print("Lỗi khi server gửi phản hồi thô: ", err)
				
				var response_variant = {"response": "Server received your message", "timestamp": OS.get_ticks_msec()}
				err = peer.put_var(response_variant, true)
				if err == OK:
					print("Server gửi phản hồi Variant tới peer ", packet_peer_id, ": ", response_variant)
				else:
					print("Lỗi khi server gửi phản hồi Variant: ", err)
	
	# Tắt _process sau 5 giây để giảm log
	if Engine.get_frames_drawn() > 300:
		set_process(false)

func _exit_tree():
	# 14. Đóng kết nối
	peer.close_connection()
	get_tree().network_peer = null
	print("Đã đóng kết nối NetworkedMultiplayerPeer.")

# Biến để theo dõi trạng thái gửi dữ liệu của client
var client_data_sent = false

# Hàm hỗ trợ để lấy tên trạng thái kết nối
func get_connection_status_name(status):
	match status:
		NetworkedMultiplayerPeer.CONNECTION_DISCONNECTED:
			return "DISCONNECTED"
		NetworkedMultiplayerPeer.CONNECTION_CONNECTING:
			return "CONNECTING"
		NetworkedMultiplayerPeer.CONNECTION_CONNECTED:
			return "CONNECTED"
		_:
			return "UNKNOWN"

# Hàm xử lý tín hiệu
func _on_connection_succeeded():
	print("Kết nối thành công!")

func _on_connection_failed():
	print("Kết nối thất bại!")

func _on_peer_connected(id):
	print("Peer mới kết nối: ", id)

func _on_peer_disconnected(id):
	print("Peer ngắt kết nối: ", id)

func _on_server_disconnected():
	print("Ngắt kết nối khỏi server!")