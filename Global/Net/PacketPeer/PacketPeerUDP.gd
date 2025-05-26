extends Node

# Biến để xác định vai trò server hay client
var is_server = false
var udp_peer = PacketPeerUDP.new()
var server_port = 4242
var client_address = "127.0.0.1"
var multicast_address = "239.0.0.1"
var multicast_interface = "" # Để trống để sử dụng mặc định

func _ready():
	# 1. Thiết lập thuộc tính kế thừa từ PacketPeer
	udp_peer.set_allow_object_decoding(true)
	if udp_peer.is_object_decoding_allowed():
		print("Cho phép giải mã object trong get_var/put_var.")
	else:
		print("Không cho phép giải mã object.")
	
	udp_peer.set_encode_buffer_max_size(1048576) # 1MB
	if udp_peer.get_encode_buffer_max_size() == 1048576:
		print("Kích thước buffer mã hóa được thiết lập thành 1MB.")
	else:
		print("Lỗi khi thiết lập kích thước buffer mã hóa.")
	
	# 2. Quyết định vai trò server hay client
	is_server = OS.get_cmdline_args().has("--server")
	
	if is_server:
		# 3. Server: Bắt đầu lắng nghe trên port
		var err = udp_peer.listen(server_port, "*", 65536)
		if err == OK:
			print("Server UDP đang lắng nghe trên port ", server_port)
		else:
			print("Lỗi khi khởi tạo server UDP: ", err)
			return
		
		# 4. Kiểm tra trạng thái lắng nghe
		if udp_peer.is_listening():
			print("Server đang ở trạng thái lắng nghe.")
		else:
			print("Server không ở trạng thái lắng nghe.")
		
		# 5. Tham gia nhóm multicast
		err = udp_peer.join_multicast_group(multicast_address, multicast_interface)
		if err == OK:
			print("Tham gia nhóm multicast ", multicast_address, " thành công.")
		else:
			print("Lỗi khi tham gia nhóm multicast: ", err)
	else:
		# 6. Client: Kết nối tới server
		var err = udp_peer.connect_to_host(client_address, server_port)
		if err == OK:
			print("Client kết nối tới ", client_address, ":", server_port)
		else:
			print("Lỗi khi kết nối tới host: ", err)
			return
		
		# 7. Kiểm tra trạng thái kết nối
		if udp_peer.is_connected_to_host():
			print("Client đã kết nối tới host.")
		else:
			print("Client không kết nối tới host.")
		
		# 8. Tham gia nhóm multicast
		err = udp_peer.join_multicast_group(multicast_address, multicast_interface)
		if err == OK:
			print("Client tham gia nhóm multicast ", multicast_address, " thành công.")
		else:
			print("Lỗi khi client tham gia nhóm multicast: ", err)
		
		# 9. Bật broadcast (cho client gửi broadcast nếu cần)
		udp_peer.set_broadcast_enabled(true)
		print("Đã bật chế độ broadcast.")
		
		# 10. Gửi gói tin thô tới server
		var raw_data = "Hello, UDP Server!".to_utf8()
		err = udp_peer.put_packet(raw_data)
		if err == OK:
			print("Client gửi gói tin thô: ", raw_data.get_string_from_utf8())
		else:
			print("Lỗi khi gửi gói tin thô: ", err)
		
		# 11. Gửi dữ liệu Variant tới server
		var variant_data = {"message": "Hello from client", "value": 42}
		err = udp_peer.put_var(variant_data, true)
		if err == OK:
			print("Client gửi dữ liệu Variant: ", variant_data)
		else:
			print("Lỗi khi gửi dữ liệu Variant: ", err)
		
		# 12. Gửi gói tin tới địa chỉ multicast
		err = udp_peer.set_dest_address(multicast_address, server_port)
		if err == OK:
			var multicast_data = "Multicast message!".to_utf8()
			err = udp_peer.put_packet(multicast_data)
			if err == OK:
				print("Client gửi gói tin multicast: ", multicast_data.get_string_from_utf8())
			else:
				print("Lỗi khi gửi gói tin multicast: ", err)
		else:
			print("Lỗi khi thiết lập địa chỉ multicast: ", err)

func _process(delta):
	# 13. Sử dụng wait để nhận gói tin (chặn)
	if udp_peer.wait() == OK:
		# 14. Kiểm tra số lượng gói tin có sẵn
		var packet_count = udp_peer.get_available_packet_count()
		if packet_count > 0:
			print("Số gói tin có sẵn: ", packet_count)
			
			# 15. Nhận và xử lý gói tin thô
			var packet = udp_peer.get_packet()
			var packet_error = udp_peer.get_packet_error()
			if packet_error == OK:
				var packet_ip = udp_peer.get_packet_ip()
				var packet_port = udp_peer.get_packet_port()
				print("Nhận gói tin thô từ ", packet_ip, ":", packet_port, ": ", packet.get_string_from_utf8())
			else:
				print("Lỗi khi nhận gói tin thô: ", packet_error)
			
			# 16. Nhận và xử lý dữ liệu Variant
			var variant = udp_peer.get_var(true)
			packet_error = udp_peer.get_packet_error()
			if packet_error == OK:
				print("Nhận dữ liệu Variant từ ", udp_peer.get_packet_ip(), ":", udp_peer.get_packet_port(), ": ", variant)
			else:
				print("Lỗi khi nhận dữ liệu Variant: ", packet_error)
			
			# 17. Server phản hồi (nếu là server)
			if is_server:
				var response_data = "Hello, Client!".to_utf8()
				var err = udp_peer.set_dest_address(udp_peer.get_packet_ip(), udp_peer.get_packet_port())
				if err == OK:
					err = udp_peer.put_packet(response_data)
					if err == OK:
						print("Server gửi phản hồi thô: ", response_data.get_string_from_utf8())
					else:
						print("Lỗi khi server gửi phản hồi thô: ", err)
				
				var response_variant = {"response": "Server received your message", "timestamp": OS.get_ticks_msec()}
				err = udp_peer.put_var(response_variant, true)
				if err == OK:
					print("Server gửi phản hồi Variant: ", response_variant)
				else:
					print("Lỗi khi server gửi phản hồi Variant: ", err)
	
	# 18. Thoát nhóm multicast (chỉ minh họa, thực tế có thể gọi khi cần)
	var err = udp_peer.leave_multicast_group(multicast_address, multicast_interface)
	if err == OK:
		print("Thoát nhóm multicast ", multicast_address, " thành công.")
	else:
		print("Lỗi khi thoát nhóm multicast: ", err)
	
	# Tắt _process sau 5 giây để giảm log
	if Engine.get_frames_drawn() > 300:
		set_process(false)

func _exit_tree():
	# 19. Đóng kết nối UDP khi thoát
	udp_peer.close()
	if not udp_peer.is_listening() and not udp_peer.is_connected_to_host():
		print("Đã đóng kết nối UDP.")
	else:
		print("Lỗi khi đóng kết nối UDP.")
