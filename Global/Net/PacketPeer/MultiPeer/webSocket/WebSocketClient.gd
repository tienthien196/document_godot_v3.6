# WebSocketClientNode.gd

extends Node

var ws_client = WebSocketClient.new()
const SERVER_URL = "ws://localhost:8080"  # Server test công cộng

func _ready():
	# --- THIẾT LẬP SSL (tuỳ chọn) ---

	# Bật kiểm tra SSL
	ws_client.set_verify_ssl_enabled(true)

	# (Optional) Chỉ chấp nhận chứng chỉ cụ thể nếu có
	# var cert = preload("res://certs/trusted.crt")
	# ws_client.set_trusted_ssl_certificate(cert)

	# --- KẾT NỐI VỚI SERVER ---

	var protocols = PoolStringArray()
	protocols.append("chat")  # Yêu cầu sub-protocol "chat"

	var custom_headers = PoolStringArray()
	custom_headers.append("X-User-Agent: GodotClient/1.0")

	var error = ws_client.connect_to_url(SERVER_URL, protocols, false, custom_headers)

	if error == OK:
		print("Đang kết nối đến %s..." % SERVER_URL)
	else:
		print("Không thể bắt đầu kết nối!")
		return

	# Kết nối các tín hiệu
	ws_client.connect("connection_established", self, "_on_connection_established")
	ws_client.connect("connection_error", self, "_on_connection_error")
	ws_client.connect("connection_closed", self, "_on_connection_closed")
	ws_client.connect("server_close_request", self, "_on_server_close_request")
	ws_client.connect("data_received", self, "_on_data_received")


func _process(delta):
	# Luôn phải gọi poll() định kỳ để xử lý kết nối và dữ liệu
	ws_client.poll()


# ---- XỬ LÝ TÍN HIỆU ----

func _on_connection_established(protocol):
	print("Kết nối thành công! Protocol đã chọn:", protocol)
	print("Đang kết nối tới:", ws_client.get_connected_host(), ":", ws_client.get_connected_port())

	# Gửi một tin nhắn thử nghiệm
	var peer = ws_client.get_peer(1)  # ID luôn là 1 cho client
	if peer:
		peer.put_packet("Hello from Godot!".to_utf8())


func _on_connection_error():
	print("Kết nối bị lỗi!")


func _on_connection_closed(was_clean_close):
	print("Kết nối đã đóng.", "Ngắt sạch:" if was_clean_close else "Ngắt đột ngột")


func _on_server_close_request(code, reason):
	print("Server yêu cầu đóng kết nối. Code: %d - Lý do: %s" % [code, reason])
	# Hãy tiếp tục poll() cho đến khi connection_closed được phát


func _on_data_received():
	var peer = ws_client.get_peer(1)
	if peer and peer.get_available_packet_count() > 0:
		var packet = peer.get_packet()
		var msg = packet.get_string_from_utf8()
		print("Nhận được từ server:", msg)

		# Ví dụ: Ngắt kết nối sau khi nhận xong
		# ws_client.disconnect_from_host(1000, "Finished")


# ---- DỪNG KẾT NỐI KHI NODE BỊ HỦY ----
func _exit_tree():
	if ws_client.is_connection_active():
		print("Đang ngắt kết nối...")
		ws_client.disconnect_from_host(1000, "Client stopped")
