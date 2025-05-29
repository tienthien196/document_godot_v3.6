extends Node2D

# --- CẤU HÌNH ---
# Cổng muốn mở (phải nằm trong khoảng 1024 - 65535)
const SERVER_PORT = 7777

# Biến lưu luồng xử lý (thread) và đối tượng UPNP
var upnp_thread: Thread
var upnp: UPNP

# --- SỰ KIỆN (Signal) ---
# Phát ra khi hoàn tất quá trình UPNP
signal upnp_completed(error)

func _ready():
	# Khởi động thread để chạy UPNP mà không làm treo game
	upnp_thread = Thread.new()
	upnp_thread.start(self, "_run_upnp_procedure", SERVER_PORT)

func _run_upnp_procedure(port):
	# Tạo đối tượng UPNP
	upnp = UPNP.new()

	# 1. discover(timeout=2000, ttl=2, device_filter="InternetGatewayDevice")
	print("🔍 Đang quét mạng để tìm thiết bị hỗ trợ UPNP...")
	var error = upnp.discover()
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi phát hiện thiết bị UPNP:", error)
		emit_signal("upnp_completed", error)
		return

	# 2. get_device_count() - Kiểm tra số lượng thiết bị phát hiện được
	var device_count = upnp.get_device_count()
	print("📦 Số lượng thiết bị UPNP phát hiện được:", device_count)

	# 3. get_gateway() - Lấy gateway mặc định
	var gateway = upnp.get_gateway()
	if not gateway or not gateway.is_valid_gateway():
		print("❌ Không tìm thấy gateway hợp lệ.")
		emit_signal("upnp_completed", UPNP.UPNP_RESULT_INVALID_GATEWAY)
		return

	# 4. query_external_address() - Lấy địa chỉ IP công cộng
	var external_ip = upnp.query_external_address()
	if external_ip == "":
		print("⚠️ Không thể lấy địa chỉ IP công cộng.")
	else:
		print("🌐 Địa chỉ IP công cộng:", external_ip)

	# 5. add_port_mapping(port, port_internal=0, desc="", proto="UDP/TCP", duration=0)
	print("🔌 Đang cố gắng mở cổng %d..." % [port])
	error = upnp.add_port_mapping(port, 0, "MyGodotGameServer", "UDP")
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi khi mở cổng UDP:", error)
	else:
		print("✅ Mở cổng UDP thành công!")

	error = upnp.add_port_mapping(port, 0, "MyGodotGameServer", "TCP")
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi khi mở cổng TCP:", error)
	else:
		print("✅ Mở cổng TCP thành công!")

	# Gửi tín hiệu hoàn tất
	emit_signal("upnp_completed", UPNP.UPNP_RESULT_SUCCESS)

func _on_upnp_completed(error):
	match error:
		UPNP.UPNP_RESULT_SUCCESS:
			print("🎉 UPNP đã được cấu hình thành công!")
		UPNP.UPNP_RESULT_NO_GATEWAY:
			print("🚫 Không tìm thấy gateway hỗ trợ UPNP.")
		UPNP.UPNP_RESULT_CONFLICT_WITH_OTHER_MAPPING:
			print("⚠️ Cổng đã tồn tại ánh xạ khác. Hãy thử cổng khác.")
		UPNP.UPNP_RESULT_SOCKET_ERROR:
			print("🔌 Có lỗi kết nối socket.")
		_:
			print("❗ UPNP thất bại với mã lỗi:", error)

func _input(event):
	# Nhấn phím ESC để đóng cổng
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		_close_port(SERVER_PORT)

func _close_port(port):
	if upnp:
		# 6. delete_port_mapping(port, proto="UDP/TCP")
		var err_udp = upnp.delete_port_mapping(port, "UDP")
		var err_tcp = upnp.delete_port_mapping(port, "TCP")

		if err_udp == UPNP.UPNP_RESULT_SUCCESS:
			print("🔓 Đã đóng cổng UDP thành công.")
		if err_tcp == UPNP.UPNP_RESULT_SUCCESS:
			print("🔓 Đã đóng cổng TCP thành công.")

func _exit_tree():
	# Nếu còn thread đang chạy thì chờ nó xong trước khi thoát
	if upnp_thread and upnp_thread.is_started():
		upnp_thread.wait_to_finish()
