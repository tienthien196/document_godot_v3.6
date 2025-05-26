extends Node

# Khởi tạo NetworkedMultiplayerENet
var network_peer = NetworkedMultiplayerENet.new()
# Khóa và chứng chỉ cho DTLS
var crypto = Crypto.new()
var dtls_key = CryptoKey.new()
var dtls_cert = X509Certificate.new()
# Cổng mặc định và số lượng client tối đa
const DEFAULT_PORT = 4242
const MAX_CLIENTS = 32
# Biến xác định server hay client
var is_server = false

func _ready():
	# Kết nối các tín hiệu của SceneTree để xử lý sự kiện mạng
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")
	
	# Kiểm tra xem đây là server hay client (giả lập qua tham số dòng lệnh)
	is_server = "--server" in OS.get_cmdline_args()
	
	# 1. always_ordered: Thiết lập chế độ luôn giữ thứ tự gói tin
	network_peer.set_always_ordered(true)
	print("always_ordered được thiết lập: ", network_peer.is_always_ordered())
	
	# 2. channel_count: Thiết lập số lượng kênh truyền dữ liệu
	network_peer.set_channel_count(4)
	print("channel_count được thiết lập: ", network_peer.get_channel_count())
	
	# 3. compression_mode: Thiết lập chế độ nén ZSTD
	network_peer.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_ZSTD)
	print("compression_mode được thiết lập: ", network_peer.get_compression_mode())
	
	# 4. dtls_hostname: Thiết lập hostname cho DTLS
	network_peer.set_dtls_hostname("localhost")
	print("dtls_hostname được thiết lập: ", network_peer.get_dtls_hostname())
	
	# 5. dtls_verify: Bật xác thực DTLS
	network_peer.set_dtls_verify_enabled(true)
	print("dtls_verify được thiết lập: ", network_peer.is_dtls_verify_enabled())
	
	# 6. server_relay: Bật chế độ relay cho server
	network_peer.set_server_relay_enabled(true)
	print("server_relay được thiết lập: ", network_peer.is_server_relay_enabled())
	
	# 7. transfer_channel: Thiết lập kênh truyền dữ liệu mặc định
	network_peer.set_transfer_channel(1)
	print("transfer_channel được thiết lập: ", network_peer.get_transfer_channel())
	
	# 8. use_dtls: Bật DTLS cho mã hóa
	network_peer.set_dtls_enabled(true)
	
	# Tạo khóa và chứng chỉ DTLS
	var rsa_key = crypto.generate_rsa(2048)
	if rsa_key:
		var cert = crypto.generate_self_signed_certificate(
			rsa_key,
			"CN=localhost,O=GameCompany,C=VN",
			"20250101000000",
			"20350101000000"
		)
		if cert:
			# 9. set_dtls_key: Thiết lập khóa DTLS
			network_peer.set_dtls_key(rsa_key)
			# 10. set_dtls_certificate: Thiết lập chứng chỉ DTLS
			network_peer.set_dtls_certificate(cert)
			print("Đã thiết lập khóa và chứng chỉ DTLS")
		else:
			print("Lỗi khi tạo chứng chỉ DTLS!")
	else:
		print("Lỗi khi tạo khóa RSA!")
	
	# 11. set_bind_ip: Thiết lập IP liên kết cho server
	network_peer.set_bind_ip("127.0.0.1")
	
	# Khởi động server hoặc client
	if is_server:
		# 12. create_server: Tạo server
		var error = network_peer.create_server(DEFAULT_PORT, MAX_CLIENTS, 0, 0)
		if error == OK:
			get_tree().set_network_peer(network_peer)
			print("Server khởi động trên cổng ", DEFAULT_PORT, " với tối đa ", MAX_CLIENTS, " client")
		else:
			print("Lỗi khi tạo server: ", error)
	else:
		# 13. create_client: Tạo client
		var error = network_peer.create_client("127.0.0.1", DEFAULT_PORT, 0, 0, 0)
		if error == OK:
			get_tree().set_network_peer(network_peer)
			print("Client đang kết nối đến 127.0.0.1:", DEFAULT_PORT)
		else:
			print("Lỗi khi tạo client: ", error)

# Xử lý khi peer kết nối
func _on_network_peer_connected(id: int):
	print("Peer ", id, " đã kết nối")
	if is_server:
		# 14. set_peer_timeout: Thiết lập thời gian chờ cho peer
		network_peer.set_peer_timeout(id, 10000, 5000, 20000)
		print("Đã thiết lập timeout cho peer ", id)
		# 15. get_peer_address và get_peer_port: Lấy địa chỉ và cổng của peer
		var peer_address = network_peer.get_peer_address(id)
		var peer_port = network_peer.get_peer_port(id)
		print("Peer ", id, " có địa chỉ: ", peer_address, " và cổng: ", peer_port)
		# Gửi thông điệp chào
		rpc_id(id, "receive_message", "Chào mừng từ server!")

# Xử lý khi peer ngắt kết nối
func _on_network_peer_disconnected(id: int):
	print("Peer ", id, " đã ngắt kết nối")

# Xử lý khi client kết nối thành công
func _on_connected_to_server():
	print("Client đã kết nối thành công đến server")
	# Gửi thông điệp chào đến server
	rpc_id(1, "receive_message", "Chào từ client!")

# Xử lý khi kết nối thất bại
func _on_connection_failed():
	print("Kết nối thất bại")
	get_tree().set_network_peer(null)

# Xử lý khi server ngắt kết nối
func _on_server_disconnected():
	print("Ngắt kết nối khỏi server")
	get_tree().set_network_peer(null)

# Hàm RPC để nhận thông điệp
remote func receive_message(message: String):
	print("Nhận được thông điệp: ", message)

# Gửi và nhận gói tin thử nghiệm
func _process(delta):
	if get_tree().has_network_peer() and get_tree().get_frame() == 300:
		if is_server:
			for peer_id in get_tree().get_network_peers():
				# Gửi thông điệp qua kênh cụ thể
				network_peer.set_transfer_channel(2)
				rpc_id(peer_id, "receive_message", "Tin nhắn thử nghiệm từ server trên kênh 2!")
				# 16. get_packet_channel: Lấy kênh của gói tin tiếp theo
				print("Kênh của gói tin tiếp theo: ", network_peer.get_packet_channel())
				# 17. get_last_packet_channel: Lấy kênh của gói tin cuối
				print("Kênh của gói tin cuối: ", network_peer.get_last_packet_channel())
		else:
			network_peer.set_transfer_channel(1)
			rpc_id(1, "receive_message", "Tin nhắn thử nghiệm từ client trên kênh 1!")
			print("Kênh của gói tin tiếp theo: ", network_peer.get_packet_channel())
			print("Kênh của gói tin cuối: ", network_peer.get_last_packet_channel())

# Đóng kết nối khi nhấn ESC
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		# 18. disconnect_peer: Ngắt kết nối một peer cụ thể (nếu là server)
		if is_server and get_tree().get_network_peers().size() > 0:
			var peer_id = get_tree().get_network_peers()[0]
			network_peer.disconnect_peer(peer_id, true)
			print("Đã ngắt kết nối peer ", peer_id)
		# 19. close_connection: Đóng toàn bộ kết nối
		network_peer.close_connection(100)
		get_tree().set_network_peer(null)
		print("Đã đóng kết nối")
