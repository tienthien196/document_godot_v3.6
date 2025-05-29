extends Node2D

# Biến lưu đối tượng StreamPeerTCP
var tcp_peer = StreamPeerTCP.new()

func _ready():
	# --- PHẦN 1: Kết nối tới máy chủ TCP ---
	var host = "example.com" # hoặc địa chỉ IP như "127.0.0.1"
	var port = 80 # cổng HTTP (hoặc bất kỳ cổng nào bạn cần)

	# connect_to_host(host, port) - Bắt đầu kết nối đến máy chủ
	var error = tcp_peer.connect_to_host(host, port)
	if error == OK:
		print("✅ Đang cố gắng kết nối tới %s:%d..." % [host, port])
	else:
		print("❌ Không thể bắt đầu kết nối tới %s:%d." % [host, port])

	# --- PHẦN 2: Kiểm tra trạng thái kết nối định kỳ ---
	# Tạo timer để kiểm tra trạng thái kết nối theo chu kỳ
	get_tree().create_timer(1.0, true).connect("timeout", self, "_check_connection_status")

func _check_connection_status():
	# get_status() - Lấy trạng thái hiện tại của kết nối
	match tcp_peer.get_status():
		StreamPeerTCP.STATUS_NONE:
			print("🔹 Trạng thái: STATUS_NONE - Chưa kết nối.")

		StreamPeerTCP.STATUS_CONNECTING:
			print("🔸 Trạng thái: STATUS_CONNECTING - Đang kết nối...")

		StreamPeerTCP.STATUS_CONNECTED:
			print("🟢 Trạng thái: STATUS_CONNECTED - Đã kết nối thành công!")

			# is_connected_to_host() - Kiểm tra xem đã kết nối chưa
			if tcp_peer.is_connected_to_host():
				print("🔗 Hiện đang kết nối với máy chủ.")

			# get_connected_host() - Lấy địa chỉ IP đã kết nối
			var ip = tcp_peer.get_connected_host()
			print("🌐 Địa chỉ IP đã kết nối: ", ip)

			# get_connected_port() - Lấy cổng đã kết nối
			var port = tcp_peer.get_connected_port()
			print("🚪 Cổng đã kết nối: ", port)

			# set_no_delay(true) - Gửi dữ liệu ngay lập tức (tắt Nagle's algorithm)
			tcp_peer.set_no_delay(true)
			print("⚡ set_no_delay(true) - Dữ liệu sẽ được gửi ngay lập tức.")

			# Gửi dữ liệu mẫu
			tcp_peer.put_data("GET / HTTP/1.1\r\nHost: example.com\r\n\r\n".to_utf8())
			
			# Nhận dữ liệu nếu có
			if tcp_peer.get_available_bytes() > 0:
				var data = tcp_peer.get_data(tcp_peer.get_available_bytes())
				print("📩 Dữ liệu nhận được:\n", data.get_string_from_utf8())

		StreamPeerTCP.STATUS_ERROR:
			print("❌ Trạng thái: STATUS_ERROR - Có lỗi xảy ra khi kết nối.")

func _input(event):
	# Nhấn phím ESC để ngắt kết nối
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		# disconnect_from_host() - Ngắt kết nối khỏi máy chủ
		tcp_peer.disconnect_from_host()
		print("🛑 Đã ngắt kết nối khỏi máy chủ.")

func _exit_tree():
	# Đảm bảo đóng kết nối khi node bị hủy
	if tcp_peer.is_connected_to_host():
		tcp_peer.disconnect_from_host()
		print("🔌 Đã tự động ngắt kết nối trước khi thoát.")
