extends Node2D

# --- CẤU HÌNH ---
const SERVER_PORT = 7777 # Cổng muốn mở (phải nằm trong khoảng 1024 - 65535)

# Biến lưu luồng xử lý (thread), danh sách thiết bị và gateway chính
var upnp_thread: Thread
var upnp: UPNP
var devices: Array = []
var gateway_device: UPNPDevice = null

# --- SỰ KIỆN (Signal) ---
signal upnp_device_completed(error)

func _ready():
	# Khởi chạy thread để tránh treo giao diện khi thực hiện tác vụ blocking
	upnp_thread = Thread.new()
	upnp_thread.start(self, "_run_upnp_device_procedure", SERVER_PORT)

func _run_upnp_device_procedure(port):
	upnp = UPNP.new()

	# 1. discover() - Tìm tất cả thiết bị UPnP trên mạng
	print("🔍 Đang quét mạng để tìm thiết bị hỗ trợ UPNP...")
	var error = upnp.discover()
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi phát hiện thiết bị UPNP:", error)
		emit_signal("upnp_device_completed", error)
		return

	# 2. get_device_count() - Lấy tổng số thiết bị phát hiện được
	var device_count = upnp.get_device_count()
	print("📦 Số lượng thiết bị UPNP phát hiện được:", device_count)

	if device_count == 0:
		print("🚫 Không tìm thấy thiết bị UPNP nào.")
		emit_signal("upnp_device_completed", UPNP.UPNP_RESULT_NO_DEVICES)
		return

	# 3. get_device(index) - Lấy từng thiết bị và kiểm tra xem có phải là gateway hợp lệ
	for i in range(device_count):
		var device: UPNPDevice = upnp.get_device(i)
		if device.is_valid_gateway():
			gateway_device = device
			break

	if not gateway_device or not gateway_device.is_valid_gateway():
		print("❌ Không tìm thấy gateway hợp lệ.")
		emit_signal("upnp_device_completed", UPNP.UPNP_RESULT_INVALID_GATEWAY)
		return

	# 4. is_valid_gateway() - Kiểm tra xem có thể dùng cổng này hay không
	if not gateway_device.is_valid_gateway():
		print("⚠️ Gateway không hỗ trợ mở cổng.")
		emit_signal("upnp_device_completed", UPNP.UPNP_RESULT_ACTION_FAILED)
		return

	# 5. query_external_address() - Lấy địa chỉ IP công cộng từ gateway
	var external_ip = gateway_device.query_external_address()
	if external_ip == "":
		print("⚠️ Không thể lấy địa chỉ IP công cộng.")
	else:
		print("🌐 Địa chỉ IP công cộng:", external_ip)

	# 6. add_port_mapping(...) - Thêm ánh xạ cổng TCP & UDP
	error = gateway_device.add_port_mapping(port, 0, "MyGodotGameServer", "UDP")
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi mở cổng UDP:", error)
	else:
		print("✅ Mở cổng UDP thành công!")

	error = gateway_device.add_port_mapping(port, 0, "MyGodotGameServer", "TCP")
	if error != UPNP.UPNP_RESULT_SUCCESS:
		print("❌ Lỗi mở cổng TCP:", error)
	else:
		print("✅ Mở cổng TCP thành công!")

	# Gửi tín hiệu hoàn tất
	emit_signal("upnp_device_completed", UPNP.UPNP_RESULT_SUCCESS)

func _on_upnp_device_completed(error):
	match error:
		UPNP.UPNP_RESULT_SUCCESS:
			print("🎉 UPNP DEVICE: Cổng đã được mở thành công!")
		UPNP.UPNP_RESULT_CONFLICT_WITH_OTHER_MAPPING:
			print("⚠️ Cổng đã tồn tại ánh xạ khác. Hãy thử cổng khác.")
		UPNP.UPNP_RESULT_SOCKET_ERROR:
			print("🔌 Có lỗi kết nối socket.")
		UPNP.UPNP_RESULT_NO_GATEWAY:
			print("🚫 Không tìm thấy gateway hỗ trợ UPNP.")
		_:
			print("❗ UPNP DEVICE: Thất bại với mã lỗi:", error)

func _input(event):
	# Nhấn phím ESC để đóng cổng
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		_close_port(SERVER_PORT)

func _close_port(port):
	if gateway_device:
		# 7. delete_port_mapping(...) - Xóa cổng TCP và UDP
		var err_udp = gateway_device.delete_port_mapping(port, "UDP")
		var err_tcp = gateway_device.delete_port_mapping(port, "TCP")

		if err_udp == UPNP.UPNP_RESULT_SUCCESS:
			print("🔓 Đã xóa cổng UDP thành công.")
		if err_tcp == UPNP.UPNP_RESULT_SUCCESS:
			print("🔓 Đã xóa cổng TCP thành công.")

func _exit_tree():
	# Nếu còn thread đang chạy thì chờ nó xong trước khi thoát
	if upnp_thread and upnp_thread.is_started():
		upnp_thread.wait_to_finish()
