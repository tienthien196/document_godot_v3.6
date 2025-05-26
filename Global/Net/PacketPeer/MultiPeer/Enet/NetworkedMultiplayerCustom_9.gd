extends Node

# Tạo instance của NetworkedMultiplayerCustom
var custom_peer: NetworkedMultiplayerCustom = NetworkedMultiplayerCustom.new()
# Lưu trữ peer ID
var my_peer_id: int
# Giả lập một danh sách các peer đã kết nối
var connected_peers: Array = []

func _ready():
	# Kết nối tín hiệu packet_generated
	custom_peer.connect("packet_generated", self, "_on_packet_generated")
	
	# Gán custom peer cho MultiplayerAPI
	get_tree().set_network_peer(custom_peer)
	
	# Xác định peer là server (ID=1) hay client (ID>1)
	my_peer_id = 1 if is_server() else 2
	
	# Khởi tạo peer
	initialize_peer()

# Hàm kiểm tra xem đây có phải là server không
func is_server() -> bool:
	# Trong thực tế, logic này có thể dựa trên tham số dòng lệnh hoặc giao diện người dùng
	return true  # Thay đổi tùy theo trường hợp

# Khởi tạo peer
func initialize_peer():
	# Thiết lập trạng thái kết nối ban đầu là CONNECTING
	custom_peer.set_connection_status(NetworkedMultiplayerPeer.CONNECTION_CONNECTING)
	
	# Khởi tạo peer với ID
	custom_peer.initialize(my_peer_id)
	
	# Thiết lập kích thước gói tin tối đa (64KB)
	custom_peer.set_max_packet_size(65536)
	
	# Giả lập kết nối thành công
	if is_server():
		custom_peer.set_connection_status(NetworkedMultiplayerPeer.CONNECTION_CONNECTED)
		print("Server khởi tạo với peer ID: ", my_peer_id)
	else:
		# Giả lập client kết nối
		custom_peer.set_connection_status(NetworkedMultiplayerPeer.CONNECTION_CONNECTED)
		print("Client khởi tạo với peer ID: ", my_peer_id)
		# Thêm server vào danh sách peer (ID=1)
		connected_peers.append(1)

# Xử lý tín hiệu packet_generated
func _on_packet_generated(peer_id: int, buffer: PoolByteArray, transfer_mode: int):
	# Gửi gói tin đến peer_id qua mạng
	print("Gói tin được tạo để gửi đến peer ", peer_id, " với kích thước: ", buffer.size())
	# Giả lập gửi gói tin (trong thực tế, bạn gửi qua mạng, ví dụ: WebSocket)
	send_packet_to_peer(peer_id, buffer)

# Hàm giả lập gửi gói tin qua mạng
func send_packet_to_peer(peer_id: int, buffer: PoolByteArray):
	# Trong thực tế, bạn sẽ gửi buffer đến peer_id qua mạng
	print("Gửi gói tin đến peer ", peer_id)
	# Giả lập peer đích nhận được gói tin
	if peer_id in connected_peers or peer_id == 1:
		receive_packet(buffer, peer_id)

# Hàm giả lập nhận gói tin từ mạng
func receive_packet(buffer: PoolByteArray, from_peer_id: int):
	# Khi nhận được gói tin từ peer khác, gọi deliver_packet để xử lý cục bộ
	custom_peer.deliver_packet(buffer, from_peer_id)
	print("Nhận gói tin từ peer ", from_peer_id, " với kích thước: ", buffer.size())

# Hàm ví dụ gửi RPC
func test_rpc():
	if is_server():
		# Gọi RPC để gửi dữ liệu đến client (peer_id=2)
		rpc_id(2, "client_receive_message", "Xin chào từ server!")
	else:
		# Gọi RPC để gửi dữ liệu đến server (peer_id=1)
		rpc_id(1, "server_receive_message", "Xin chào từ client!")

# Hàm RPC chạy trên client
remote func client_receive_message(message: String):
	print("Client nhận được: ", message)

# Hàm RPC chạy trên server
remote func server_receive_message(message: String):
	print("Server nhận được: ", message)

# Hàm để kiểm tra kết nối
func _process(delta):
	# Giả lập gọi RPC sau 5 giây
	if get_tree().get_frame() == 300:
		test_rpc()
