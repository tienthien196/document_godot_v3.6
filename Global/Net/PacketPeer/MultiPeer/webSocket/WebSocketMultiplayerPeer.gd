# WebSocketMultiplayerNode.gd

extends Node

var ws_server = WebSocketServer.new()
const PORT = 8080

func _ready():
	# --- CẤU HÌNH BUFFER ---
	# Cấu hình kích thước buffer: input/output mỗi client
	var err = ws_server.set_buffers(
		4,   # Input buffer size (KB) - 4 KiB
		64,  # Max số packet trong hàng đợi input
		4,   # Output buffer size (KB)
		64   # Max số packet trong hàng đợi output
	)
	if err != OK:
		print("Không thể cấu hình buffer!")

	# --- BẮT ĐẦU LẮNG NGHE ---
	var protocols = PoolStringArray()
	protocols.append("multiplayer")  # Sub-protocol hỗ trợ MultiplayerAPI
	var error = ws_server.listen(PORT, protocols, true)  # gd_mp_api = true

	if error == OK:
		print("WebSocket server đang chạy trên ws://*:%d" % PORT)
	else:
		print("Không thể bắt đầu server!")
		return

	# Kết nối tín hiệu peer_packet (chỉ kích hoạt khi dùng MultiplayerAPI)
	ws_server.connect("peer_packet", self, "_on_peer_packet")

func _process(delta):
	ws_server.poll()  # Phải gọi poll định kỳ


# ---- XỬ LÝ TÍN HIỆU ----

func _on_peer_packet(peer_id):
	print("Nhận gói tin từ peer ID:", peer_id)

	# Lấy đối tượng WebSocketPeer tương ứng
	var peer = ws_server.get_peer(peer_id)
	if peer and peer.get_available_packet_count() > 0:
		var packet = peer.get_packet()
		var msg = packet.get_string_from_utf8()
		print("Nội dung gói tin: '%s'" % msg)

		# Gửi lại phản hồi (nếu cần)
		peer.put_packet("Phản hồi từ server: ".to_utf8() + msg)


# ---- DỪNG SERVER KHI NODE BỊ HỦY ----
func _exit_tree():
	if ws_server.is_listening():
		print("Dừng server...")
		ws_server.stop()
