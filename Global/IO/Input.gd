extends Node2D

func _ready():
	# === 1. Input.get_action_strength(action) - Lấy độ mạnh của hành động (0 -> 1) ===
	var action = "move_right"
	print("Độ mạnh của '", action, "': ", Input.get_action_strength(action))

	# === 2. Input.get_axis(negative_action, positive_action) - Tính giá trị trục từ hai hành động ===
	var axis_value = Input.get_axis("move_left", "move_right")
	print("Giá trị trục từ move_left và move_right: ", axis_value)

	# === 3. Input.get_connected_joypads() - Trả về danh sách thiết bị tay cầm đang kết nối ===
	var joypads = Input.get_connected_joypads()
	print("Các tay cầm đang kết nối:", joypads)

	# === 4. Input.get_current_cursor_shape() - Lấy hình dạng con trỏ hiện tại ===
	var cursor_shape = Input.get_current_cursor_shape()
	print("Hình dạng con trỏ hiện tại:", cursor_shape)

	# === 5. Input.get_mouse_button_mask() - Lấy trạng thái các nút chuột đang nhấn ===
	var mouse_mask = Input.get_mouse_button_mask()
	print("Các nút chuột đang nhấn:", mouse_mask)

	# === 6. Input.get_mouse_mode() - Lấy chế độ chuột hiện tại ===
	var mouse_mode = Input.get_mouse_mode()
	print("Chế độ chuột hiện tại:", mouse_mode)


	# === 8. Input.is_action_just_pressed(action) - Kiểm tra hành động vừa được nhấn chưa? ===
	print("Kiểm tra 'move_right' vừa nhấn?", Input.is_action_just_pressed("move_right"))

	# === 9. Input.is_action_just_released(action) - Kiểm tra hành động vừa thả chưa? ===
	print("Kiểm tra 'move_right' vừa thả?", Input.is_action_just_released("move_right"))

	# === 10. Input.is_action_pressed(action) - Hành động có đang được nhấn không? ===
	print("Hành động 'move_right' đang nhấn không?", Input.is_action_pressed("move_right"))

	# === 11. Input.is_key_pressed(scancode) - Phím có đang được nhấn không? ===
	print("Phím ESCAPE có đang nhấn không?", Input.is_key_pressed(KEY_ESCAPE))

	# === 12. Input.is_mouse_button_pressed(button) - Nút chuột có đang được nhấn không? ===
	print("Nút chuột trái có đang nhấn không?", Input.is_mouse_button_pressed(BUTTON_LEFT))

	# === 13. Input.parse_input_event(event) - Xử lý một InputEvent bất kỳ ===
	var event = InputEventKey.new()
	event.scancode = KEY_A
	event.pressed = true
	Input.parse_input_event(event)
	print("Đã gửi sự kiện phím A")

	# === 14. Input.remove_joy_mapping(guid) - Xóa mapping tay cầm theo GUID ===
	# Ví dụ giả lập GUID (mỗi tay cầm có một GUID riêng)
	Input.remove_joy_mapping("03000000504944560000000000000000")  # Giả lập xóa mapping
	print("Đã xóa mapping tay cầm với GUID cụ thể")

	# === 15. Input.set_mouse_mode(mode) - Thiết lập chế độ chuột ===
	# Các chế độ: MOUSE_MODE_VISIBLE, MOUSE_MODE_HIDDEN, MOUSE_MODE_CAPTURED, MOUSE_MODE_CONFINED
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("Chế độ chuột đã đặt thành VISIBLE")

	# === 16. Input.set_custom_mouse_cursor(image, shape, hotspot) - Đặt con trỏ chuột tùy chỉnh ===
	var cursor_image = Image.new()
	cursor_image.create(16, 16, false, Image.FORMAT_RGBA8)
	cursor_image.fill(Color(1, 1, 1, 1))
	Input.set_custom_mouse_cursor(cursor_image, Input.CURSOR_ARROW, Vector2.ZERO)
	print("Đã đặt con trỏ chuột tùy chỉnh")

	# === 17. Input.warp_mouse(position) - Di chuyển chuột đến vị trí cụ thể ===
	Input.warp_mouse_position(Vector2(100, 100))
	print("Di chuyển chuột đến (100, 100)")
