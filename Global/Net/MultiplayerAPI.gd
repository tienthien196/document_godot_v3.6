extends Node

# Tạo một MultiplayerAPI tùy chỉnh
var multiplayer_api = MultiplayerAPI.new()
var is_server = false

func _ready():
	# Thiết lập MultiplayerAPI tùy chỉnh cho node này
	set_custom_multiplayer(multiplayer_api)
	
	# Kết nối các tín hiệu của MultiplayerAPI
	multiplayer_api.connect("connected_to_server", self, "_on_connected_to_server")
	multiplayer_api.connect("connection_failed", self, "_on_connection_failed")
	multiplayer_api.connect("network_peer_connected", self, "_on_network_peer_connected")
	multiplayer_api.connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	multiplayer_api.connect("network_peer_packet", self, "_on_network_peer_packet")
	multiplayer_api.connect("server_disconnected", self, "_on_server_disconnected")
	
	# 1. Kiểm tra và thiết lập thuộc tính allow_object_decoding
	multiplayer_api.set_allow_object_decoding(true)
	if multiplayer_api.is_object_decoding_allowed():
		print("Cho phép giải mã object trong RPC/RSET.")
	else:
		print("Không cho phép giải mã object.")
	
	# 2. Thiết lập root_node
	multiplayer_api.set_root_node(self)
	if multiplayer_api.get_root_node() == self:
		print("Root node được thiết lập thành công: ", get_path())
	else:
		print("Lỗi khi thiết lập root node.")
	
	# 3. Kiểm tra trước khi thiết lập network_peer
	if not multiplayer_api.has_network_peer():
		print("Chưa có network peer được thiết lập.")
	
	# 4. Thiết lập network peer (server hoặc client)
	var peer = NetworkedMultiplayerENet.new()
	var server_port = 4242
	var max_players = 4
	
	# Quyết định chạy server hay client dựa trên tham số dòng lệnh hoặc logic khác
	is_server = OS.get_cmdline_args().has("--server")
	
	if is_server:
		# Thiết lập server
		var err = peer.create_server(server_port, max_players)
		if err == OK:
			print("Tạo server thành công trên port ", server_port)
			multiplayer_api.set_network_peer(peer)
		else:
			print("Lỗi khi tạo server: ", err)
			return
	else:
		# Thiết lập client
		var err = peer.create_client("localhost", server_port)
		if err == OK:
			print("Tạo client kết nối tới localhost:", server_port)
			multiplayer_api.set_network_peer(peer)
		else:
			print("Lỗi khi tạo client: ", err)
			return
	
	# 5. Kiểm tra trạng thái network peer
	if multiplayer_api.has_network_peer():
		print("Network peer được thiết lập: ", multiplayer_api.get_network_peer())
	else:
		print("Không thể thiết lập network peer.")
	
	# 6. Kiểm tra xem có phải server không
	if multiplayer_api.is_network_server():
		print("Đây là server (ID: ", multiplayer_api.get_network_unique_id(), ")")
	else:
		print("Đây là client (ID: ", multiplayer_api.get_network_unique_id(), ")")
	
	# 7. Thiết lập từ chối kết nối mới
	multiplayer_api.set_refuse_new_network_connections(true)
	if multiplayer_api.is_refusing_new_network_connections():
		print("Từ chối các kết nối mới.")
	else:
		print("Cho phép các kết nối mới.")
	
	# 8. Gửi dữ liệu mẫu tới tất cả peer
	var sample_data = "Hello, Multiplayer!".to_utf8()
	var err = multiplayer_api.send_bytes(sample_data, 0, NetworkedMultiplayerPeer.TRANSFER_MODE_RELIABLE)
	if err == OK:
		print("Gửi dữ liệu tới tất cả peer thành công.")
	else:
		print("Lỗi khi gửi dữ liệu: ", err)

func _process(delta):
	# 9. Poll MultiplayerAPI thủ công (vì sử dụng custom MultiplayerAPI)
	if multiplayer_api.has_network_peer():
		multiplayer_api.poll()
	
	# 10. In danh sách peer được kết nối
	var peers = multiplayer_api.get_network_connected_peers()
	if not peers.empty():
		print("Các peer đang kết nối: ", peers)
	
	# 11. Kiểm tra ID của RPC sender (thường là 0 nếu không trong RPC)
	var rpc_sender_id = multiplayer_api.get_rpc_sender_id()
	if rpc_sender_id == 0:
		print("Không có RPC đang được thực thi.")
	else:
		print("RPC sender ID: ", rpc_sender_id)
	
	# Tắt _process sau 5 giây để giảm log
	if Engine.get_frames_drawn() > 300:
		set_process(false)

# Hàm xử lý tín hiệu
func _on_connected_to_server():
	print("Kết nối tới server thành công!")

func _on_connection_failed():
	print("Kết nối tới server thất bại!")

func _on_network_peer_connected(id):
	print("Peer mới kết nối: ", id)
	
	# Gửi dữ liệu chào mừng tới peer mới (chỉ server thực hiện)
	if multiplayer_api.is_network_server():
		var welcome_msg = ("Welcome, peer " + str(id) + "!").to_utf8()
		var err = multiplayer_api.send_bytes(welcome_msg, id, NetworkedMultiplayerPeer.TRANSFER_MODE_RELIABLE)
		if err == OK:
			print("Gửi tin nhắn chào mừng tới peer ", id)
		else:
			print("Lỗi khi gửi tin nhắn chào mừng: ", err)

func _on_network_peer_disconnected(id):
	print("Peer đã ngắt kết nối: ", id)

func _on_network_peer_packet(id, packet):
	print("Nhận dữ liệu từ peer ", id, ": ", packet.get_string_from_utf8())

func _on_server_disconnected():
	print("Ngắt kết nối khỏi server!")

func _exit_tree():
	# 12. Xóa trạng thái MultiplayerAPI khi thoát
	multiplayer_api.clear()
	print("Đã xóa trạng thái MultiplayerAPI.")