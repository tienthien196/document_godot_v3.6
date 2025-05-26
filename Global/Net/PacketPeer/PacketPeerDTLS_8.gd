extends Node

# Biến để xác định vai trò server hay client
var is_server = false
var udp_peer = PacketPeerUDP.new()
var dtls_server = DTLSServer.new()
var dtls_peer = PacketPeerDTLS.new()
var server_port = 4242
var client_address = "127.0.0.1"
var cert = load("res://server.crt") # Giả định chứng chỉ server
var key = load("res://server.key") # Giả định khóa riêng server

func _ready():
	# 1. Thiết lập thuộc tính kế thừa từ PacketPeer
	dtls_peer.set_allow_object_decoding(true)
	if dtls_peer.is_object_decoding_allowed():
		print("Cho phép giải mã object trong get_var/put_var.")
	else:
		print("Không cho phép giải mã object.")
	
	dtls_peer.set_encode_buffer_max_size(1048576) # 1MB
	if dtls_peer.get_encode_buffer_max_size() == 1048576:
		print("Kích thước buffer mã hóa được thiết lập thành 1MB.")
	else:
		print("Lỗi khi thiết lập kích thước buffer mã hóa.")
	
	# 2. Quyết định vai trò server hay client
	is_server = OS.get_cmdline_args().has("--server")
	
	if is_server:
		# 3. Server: Thiết lập UDP server
		var err = udp_peer.listen(server_port, "*", 65536)
		if err == OK:
			print("Server UDP đang lắng nghe trên port ", server_port)
		else:
			print("Lỗi khi khởi tạo server UDP: ", err)
			return
		
		# 4. Thiết lập DTLSServer
		err = dtls_server.setup(key, cert)
		if err == OK:
			print("Thiết lập DTLSServer thành công.")
		else:
			print("Lỗi khi thiết lập DTLSServer: ", err)
			return
	else:
		# 5. Client: Kết nối tới server qua UDP
		var err = udp_peer.set_dest_address(client_address, server_port)
		if err == OK:
			print("Client UDP được thiết lập để gửi tới ", client_address, ":", server_port)
		else:
			print("Lỗi khi thiết lập địa chỉ đích cho client: ", err)
			return
		
		# 6. Kết nối DTLS tới server
		err = dtls_peer.connect_to_peer(udp_peer, true, "localhost", cert)
		if err == OK:
			print("Client DTLS bắt đầu kết nối tới server.")
		else:
			print("Lỗi khi kết nối DTLS: ", err)
			return

func _process(delta):
	# 7. Poll DTLS để cập nhật trạng thái
	dtls_peer.poll()
	
	# 8. Kiểm tra trạng thái DTLS
	var status = dtls_peer.get_status()
	print("Trạng thái DTLS: ", get_status_name(status))
	
	if status == PacketPeerDTLS.STATUS_CONNECTED:
		if is_server:
			# Server: Kiểm tra kết nối DTLS từ client
			if udp_peer.get_available_packet_count() > 0:
				dtls_peer = dtls_server.take_connection(udp_peer)
				if dtls_peer and dtls_peer.get_status() != PacketPeerDTLS.STATUS_DISCONNECTED:
					print("Server chấp nhận kết nối DTLS từ client.")
				else:
					print("Không có kết nối DTLS hợp lệ.")
					return
		else:
			# Client: Gửi dữ liệu khi kết nối DTLS thành công
			if not client_data_sent:
				# 9. Gửi gói tin thô
				var raw_data = "Hello, DTLS Server!".to_utf8()
				var err = dtls_peer.put_packet(raw_data)
				if err == OK:
					print("Client gửi gói tin thô: ", raw_data.get_string_from_utf8())
				else:
					print("Lỗi khi gửi gói tin thô: ", err)
				
				# 10. Gửi dữ liệu Variant
				var variant_data = {"message": "Hello from client", "value": 42}
				err = dtls_peer.put_var(variant_data, true)
				if err == OK:
					print("Client gửi dữ liệu Variant: ", variant_data)
				else:
					print("Lỗi khi gửi dữ liệu Variant: ", err)
				client_data_sent = true
	
	# 11. Xử lý gói tin nhận được
	if dtls_peer.get_status() == PacketPeerDTLS.STATUS_CONNECTED:
		var packet_count = dtls_peer.get_available_packet_count()
		if packet_count > 0:
			print("Số gói tin có sẵn: ", packet_count)
			
			# 12. Nhận gói tin thô
			var packet = dtls_peer.get_packet()
			var packet_error = dtls_peer.get_packet_error()
			if packet_error == OK:
				print("Nhận gói tin thô: ", packet.get_string_from_utf8())
			else:
				print("Lỗi khi nhận gói tin thô: ", packet_error)
			
			# 13. Nhận dữ liệu Variant
			var variant = dtls_peer.get_var(true)
			packet_error = dtls_peer.get_packet_error()
			if packet_error == OK:
				print("Nhận dữ liệu Variant: ", variant)
			else:
				print("Lỗi khi nhận dữ liệu Variant: ", packet_error)
			
			# 14. Server phản hồi
			if is_server:
				var response_data = "Hello, DTLS Client!".to_utf8()
				var err = dtls_peer.put_packet(response_data)
				if err == OK:
					print("Server gửi phản hồi thô: ", response_data.get_string_from_utf8())
				else:
					print("Lỗi khi server gửi phản hồi thô: ", err)
				
				var response_variant = {"response": "Server received your message", "timestamp": OS.get_ticks_msec()}
				err = dtls_peer.put_var(response_variant, true)
				if err == OK:
					print("Server gửi phản hồi Variant: ", response_variant)
				else:
					print("Lỗi khi server gửi phản hồi Variant: ", err)
	
	# Tắt _process sau 5 giây để giảm log
	if Engine.get_frames_drawn() > 300:
		set_process(false)

func _exit_tree():
	# 15. Ngắt kết nối DTLS và đóng UDP
	dtls_peer.disconnect_from_peer()
	if dtls_peer.get_status() == PacketPeerDTLS.STATUS_DISCONNECTED:
		print("Đã ngắt kết nối DTLS.")
	else:
		print("Lỗi khi ngắt kết nối DTLS: ", get_status_name(dtls_peer.get_status()))
	
	udp_peer.close()
	print("Đã đóng kết nối UDP.")

# Biến để theo dõi trạng thái gửi dữ liệu của client
var client_data_sent = false

# Hàm hỗ trợ để lấy tên trạng thái
func get_status_name(status):
	match status:
		PacketPeerDTLS.STATUS_DISCONNECTED:
			return "DISCONNECTED"
		PacketPeerDTLS.STATUS_HANDSHAKING:
			return "HANDSHAKING"
		PacketPeerDTLS.STATUS_CONNECTED:
			return "CONNECTED"
		PacketPeerDTLS.STATUS_ERROR:
			return "ERROR"
		PacketPeerDTLS.STATUS_ERROR_HOSTNAME_MISMATCH:
			return "ERROR_HOSTNAME_MISMATCH"
		_:
			return "UNKNOWN"
