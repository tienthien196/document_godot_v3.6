# WebSocketServerNode.gd

extends Node

var ws_server = WebSocketServer.new()
const PORT = 8080

func _ready():
	# --- CÁC THIẾT LẬP THUỘC TÍNH ---

	# Thiết lập IP bind (nghe trên mọi địa chỉ)
	ws_server.set_bind_ip("127.0.0.1")  # hoặc "127.0.0.1" nếu muốn server chỉ nghe localhost
	
	# Thiết lập timeout handshake (thời gian chờ client hoàn thành kết nối ban đầu)
	ws_server.set_handshake_timeout(5.0)

	# Thêm header tùy chọn cho HTTP handshake
	var extra_headers = PoolStringArray()
	extra_headers.append("Server: MyGameServer/1.0")
	extra_headers.append("X-Powered-By: Godot")
	ws_server.set_extra_headers(extra_headers)

	# (Optional) Cài đặt SSL (nếu có chứng chỉ)
	# var cert = preload("res://certs/server.crt")
	# var key = preload("res://certs/server.key")
	# ws_server.set_ssl_certificate(cert)
	# ws_server.set_private_key(key)

	# Bắt đầu lắng nghe cổng 8080 với sub-protocol "chat"
	var protocols = PoolStringArray()
	protocols.append("chat")
	var error = ws_server.listen(PORT, protocols, false)

	if error == OK:
		print("WebSocket server đang chạy trên ws://*:%d" % PORT)
	else:
		print("Không thể bắt đầu server!")
		return

	# Kết nối các tín hiệu
	ws_server.connect("client_connected", self, "_on_client_connected")
	ws_server.connect("client_disconnected", self, "_on_client_disconnected")
	ws_server.connect("client_close_request", self, "_on_client_close_request")
	ws_server.connect("data_received", self, "_on_data_received")

func _process(delta):
	# Luôn phải gọi poll() định kỳ để xử lý kết nối và dữ liệu
	ws_server.poll()

# ---- XỬ LÝ TÍN HIỆU ----

func _on_client_connected(id, protocol):
	print("Client ID %d đã kết nối với protocol: %s" % [id, protocol])
	print("Địa chỉ client: %s:%d" % [ws_server.get_peer_address(id), ws_server.get_peer_port(id)])

	if ws_server.has_peer(id):
		print("Client ID %d vẫn còn kết nối." % id)

func _on_client_disconnected(id, was_clean_close):
	print("Client ID %d đã ngắt kết nối. Ngắt sạch: %s" % [id, str(was_clean_close)])

func _on_client_close_request(id, code, reason):
	print("Client ID %d yêu cầu ngắt kết nối. Code: %d - Lý do: %s" % [id, code, reason])

func _on_data_received(id):
	var peer = ws_server.get_peer(id)
	if peer and peer.get_available_packet_count() > 0:
		var packet = peer.get_packet()
		var msg = packet.get_string_from_utf8()
		print("Nhận được từ Client %d: %s" % [id, msg])

		# Gửi phản hồi lại cho client
		peer.put_packet(("Echo: " + msg).to_utf8())

		# Ví dụ: Ngắt kết nối client sau khi nhận xong
		# ws_server.disconnect_peer(id, 1000, "Finished")


# ---- DỪNG SERVER KHI NODE BỊ HỦY ----
func _exit_tree():
	if ws_server.is_listening():
		print("Dừng server...")
		ws_server.stop()
