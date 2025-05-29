extends Node

# Khai báo biến
var ws_client = WebSocketClient.new()
var connected_peer: WebSocketPeer

func _ready():
	# Kết nối đến máy chủ WebSocket
	var err = ws_client.connect_to_url("ws://echo.websocket.org")
	if err != OK:
		print("Không thể kết nối tới URL")
		return

	# Chờ kết nối thành công
	while ws_client.get_connection_status() == WebSocketClient.CONNECTION_CONNECTING:
		yield(get_tree(), "idle_frame")

	if ws_client.get_connection_status() == WebSocketClient.CONNECTION_CONNECTED:
		print("Đã kết nối thành công!")
		connected_peer = ws_client.get_peer(1)  # Lấy peer với ID=1

		# Gọi tất cả các phương thức khả dụng trên WebSocketPeer
		test_websocketpeer_methods(connected_peer)
	else:
		print("Kết nối thất bại!")

func test_websocketpeer_methods(peer: WebSocketPeer):
	# --- is_connected_to_host ---
	print("is_connected_to_host: ", peer.is_connected_to_host())

	# --- get_write_mode / set_write_mode ---
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	print("get_write_mode (TEXT): ", peer.get_write_mode())
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_BINARY)
	print("get_write_mode (BINARY): ", peer.get_write_mode())

	# --- was_string_packet ---
	peer.put_packet("Hello".to_utf8())  # Gửi packet đầu tiên
	var data = peer.get_packet()  # Nhận lại dữ liệu
	print("was_string_packet: ", peer.was_string_packet())

	# --- get_connected_host / get_connected_port ---
	print("get_connected_host: ", peer.get_connected_host())
	print("get_connected_port: ", peer.get_connected_port())

	# --- get_current_outbound_buffered_amount ---
	print("Buffered amount: ", peer.get_current_outbound_buffered_amount())

	# --- set_no_delay ---
	peer.set_no_delay(true)
	print("No delay đã được bật")

	# --- close ---
	print("Đang đóng kết nối...")
	peer.close(1000, "Tạm biệt!")

	# Kiểm tra trạng thái kết nối sau khi close
	print("Vẫn còn kết nối?", peer.is_connected_to_host())
