extends Node

# Biến để xác định vai trò server hay client
var is_server = false
var udp_peer = PacketPeerUDP.new()
var server_port = 4242
var client_address = "127.0.0.1"

func _ready():
	# 1. Thiết lập thuộc tính allow_object_decoding 
	#---- cho phép decode object data-----
	udp_peer.set_allow_object_decoding(true)
	if udp_peer.is_object_decoding_allowed():
		print("Cho phép giải mã object trong get_var/put_var.")
	else:
		print("Không cho phép giải mã object.")
	
	# 2. Thiết lập encode_buffer_max_size
	udp_peer.set_encode_buffer_max_size(1048576) # 1MB
	if udp_peer.get_encode_buffer_max_size() == 1048576:
		print("Kích thước buffer mã hóa được thiết lập thành 1MB.")
	else:
		print("Lỗi khi thiết lập kích thước buffer mã hóa.")
	
	# 3. Quyết định vai trò server hay client dựa trên tham số dòng lệnh
	is_server = OS.get_cmdline_args().has("--server")
	
	if is_server:
		# Thiết lập server UDP
		var err = udp_peer.listen(server_port)
		if err == OK:
			print("Server UDP đang lắng nghe trên port ", server_port)
		else:
			print("Lỗi khi khởi tạo server UDP: ", err)
			return
	else:
		# Thiết lập client UDP
		var err = udp_peer.set_dest_address(client_address, server_port)
		if err == OK:
			print("Client UDP được thiết lập để gửi tới ", client_address, ":", server_port)
		else:
			print("Lỗi khi thiết lập địa chỉ đích cho client: ", err)
			return
	
	# 4. Gửi dữ liệu mẫu ------(raw packet)----- nếu là client
	if not is_server:
		var raw_data = "Hello, UDP Server!".to_utf8()
		var err = udp_peer.put_packet(raw_data)
		if err == OK:
			print("Gửi gói tin thô thành công: ", raw_data.get_string_from_utf8())
		else:
			print("Lỗi khi gửi gói tin thô: ", err)
		
		# 5. Gửi dữ liệu----- Variant-------
		var variant_data = {"message": "Hello from client", "value": 42}
		err = udp_peer.put_var(variant_data, true)
		if err == OK:
			print("Gửi dữ liệu Variant thành công: ", variant_data)
		else:
			print("Lỗi khi gửi dữ liệu Variant: ", err)

func _process(delta):
	# 6. Kiểm tra số lượng gói tin có sẵn
	var packet_count = udp_peer.get_available_packet_count()
	if packet_count > 0:
		print("Số gói tin có sẵn: ", packet_count)
		
		# 7. Nhận và xử lý gói tin thô
		var packet = udp_peer.get_packet()
		var packet_error = udp_peer.get_packet_error()
		
		if packet_error == OK:
			print("Nhận gói tin thô: ", packet.get_string_from_utf8())
		else:
			print("Lỗi khi nhận gói tin thô: ", packet_error)
		
		# 8. Nhận và xử lý dữ liệu Variant
		var variant = udp_peer.get_var(true)
		packet_error = udp_peer.get_packet_error()
		if packet_error == OK:
			print("Nhận dữ liệu Variant: ", variant)
		else:
			print("Lỗi khi nhận dữ liệu Variant: ", packet_error)
	
	# 9. Phản hồi từ server (nếu là server)
	if is_server and packet_count > 0:
		var response_data = "Hello, Client!".to_utf8()
		var err = udp_peer.put_packet(response_data)
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
	
	# Tắt _process sau 5 giây để giảm log
	if Engine.get_frames_drawn() > 300:
		set_process(false)

func _exit_tree():
	# 10. Đóng kết nối UDP khi thoát
	udp_peer.close()
	print("Đã đóng kết nối UDP.")