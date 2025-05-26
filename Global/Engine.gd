extends Node2D

func _ready():
	# === THUỘC TÍNH ===

	# 1. Engine.editor_hint - Kiểm tra có đang chạy trong editor không?
	print("Đang chạy trong editor? ", Engine.editor_hint)

	# 2. Engine.iterations_per_second - Số lần xử lý vật lý mỗi giây
	Engine.iterations_per_second = 60
	print("Iterations per second: ", Engine.iterations_per_second)

	# 3. Engine.physics_jitter_fix - Giảm jitter khi FPS giảm đột ngột
	Engine.physics_jitter_fix = 0.5
	print("Physics jitter fix: ", Engine.physics_jitter_fix)

	# 4. Engine.print_error_messages - Bật/tắt in lỗi ra console
	Engine.print_error_messages = true
	print("In lỗi ra console: ", Engine.print_error_messages)

	# 5. Engine.target_fps - FPS mục tiêu (0 là không giới hạn)
	Engine.target_fps = 60
	print("FPS mục tiêu: ", Engine.target_fps)

	# 6. Engine.time_scale - Điều chỉnh tốc độ thời gian trò chơi
	Engine.time_scale = 1.0
	print("Tốc độ thời gian trò chơi: ", Engine.time_scale)

	# === PHƯƠNG THỨC ===

	# 7. Engine.get_author_info() - Lấy thông tin tác giả engine
	var author_info = Engine.get_author_info()
	print("Thông tin tác giả: ", author_info)

	# 8. Engine.get_copyright_info() - Lấy thông tin bản quyền
	var copyright_info = Engine.get_copyright_info()
	print("Thông tin bản quyền: ", copyright_info)

	# 9. Engine.get_donor_info() - Lấy thông tin nhà tài trợ
	var donor_info = Engine.get_donor_info()
	print("Thông tin tài trợ: ", donor_info)

	# 10. Engine.get_frames_drawn() - Số frame đã vẽ
	print("Số frame đã vẽ: ", Engine.get_frames_drawn())

	# 11. Engine.get_frames_per_second() - FPS hiện tại
	print("FPS hiện tại: ", Engine.get_frames_per_second())

	# 12. Engine.get_idle_frames() - Tổng số frame xử lý (kể cả render)
	print("Tổng số frame xử lý: ", Engine.get_idle_frames())

	# 13. Engine.get_license_info() - Thông tin giấy phép
	var license_info = Engine.get_license_info()
	print("Thông tin giấy phép: ", license_info)

	# 14. Engine.get_license_text() - Văn bản giấy phép
	var license_text = Engine.get_license_text()
	print("Văn bản giấy phép: ", license_text.left(100))  # Chỉ in 100 ký tự đầu tiên

	# 15. Engine.get_main_loop() - Lấy đối tượng MainLoop
	var main_loop = Engine.get_main_loop()
	print("Main loop: ", main_loop)

	# 16. Engine.get_physics_frames() - Số lần xử lý vật lý
	print("Số frame vật lý: ", Engine.get_physics_frames())

	# 17. Engine.get_physics_interpolation_fraction() - Tỷ lệ giữa frame vật lý và frame render
	print("Tỷ lệ nội suy vật lý: ", Engine.get_physics_interpolation_fraction())

	# 18. Engine.get_singleton(name) - Truy cập singleton toàn cục
	if Engine.has_singleton("SceneManager"):
		var scene_manager = Engine.get_singleton("SceneManager")
		print("SceneManager singleton: ", scene_manager)
	else:
		print("Không tìm thấy SceneManager singleton.")

	# 19. Engine.get_version_info() - Thông tin phiên bản engine
	var version_info = Engine.get_version_info()
	print("Phiên bản engine: ", version_info["string"])
	print("Major: ", version_info["major"], " Minor: ", version_info["minor"], " Patch: ", version_info["patch"])

	# 20. Engine.has_singleton(name) - Kiểm tra singleton tồn tại
	print("SceneManager có tồn tại không? ", Engine.has_singleton("SceneManager"))

	# 21. Engine.is_in_physics_frame() - Có đang ở trong frame vật lý không?
	print("Có đang trong frame vật lý không? ", Engine.is_in_physics_frame())
