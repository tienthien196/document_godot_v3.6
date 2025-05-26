extends Node2D

# Hàm chạy khi nút "Ready" được gọi (tự động)
func _ready():
	# 1. OS.clipboard - Sao chép văn bản vào clipboard hệ thống
	OS.clipboard = "Đây là nội dung trong clipboard"
	print("Clipboard: ", OS.get_clipboard())  # Lấy lại giá trị đã đặt
	
	# 2. OS.current_screen - Thiết lập màn hình hiện tại (bắt đầu từ 0)
	OS.current_screen = 0  # Thường chỉ có 1 màn hình, trừ khi dùng nhiều màn hình
	print("Màn hình hiện tại: ", OS.get_current_screen())

	# 3. OS.delta_smoothing - Làm mịn delta time giữa các frame nếu bật VSync
	OS.delta_smoothing = true  # Giảm biến động FPS nhẹ
	print("Delta Smoothing Bật:", OS.is_delta_smoothing_enabled())

	# 4. OS.exit_code - Mã thoát chương trình (0 là thành công)
	OS.exit_code = 0
	print("Exit Code: ", OS.get_exit_code())

	# 5. OS.keep_screen_on - Giữ màn hình luôn sáng (dành cho mobile)
	OS.keep_screen_on = true
	print("Giữ màn hình sáng: ", OS.is_keep_screen_on())

	# 6. OS.low_processor_usage_mode - Tiết kiệm CPU bằng cách ngủ giữa các frame
	OS.low_processor_usage_mode = true
	print("Chế độ tiết kiệm CPU: ", OS.is_in_low_processor_usage_mode())

	# 7. OS.low_processor_usage_mode_sleep_usec - Thời gian nghỉ giữa các frame (micro giây)
	OS.low_processor_usage_mode_sleep_usec = 10000  # 10ms
	print("Thời gian nghỉ mỗi frame: ", OS.get_low_processor_usage_mode_sleep_usec(), " micro giây")

	# 8. OS.max_window_size - Kích thước tối đa cửa sổ
	OS.max_window_size = Vector2(1280, 720)
	print("Kích thước tối đa cửa sổ: ", OS.get_max_window_size())

	# 9. OS.min_window_size - Kích thước tối thiểu cửa sổ
	OS.min_window_size = Vector2(640, 480)
	print("Kích thước tối thiểu cửa sổ: ", OS.get_min_window_size())

	# 10. OS.screen_orientation - Hướng xoay màn hình
	OS.screen_orientation = OS.SCREEN_ORIENTATION_SENSOR_PORTRAIT 
	print("Hướng màn hình: ", OS.get_screen_orientation())

	# 11. OS.tablet_driver - Trình điều khiển tablet đang dùng
	print("Trình điều khiển tablet: ", OS.get_current_tablet_driver())

	# 12. OS.vsync_enabled - Bật VSync để đồng bộ hóa khung hình với màn hình
	OS.vsync_enabled = true
	print("VSync Bật: ", OS.is_vsync_enabled())

	# 13. OS.vsync_via_compositor - Dùng compositor hệ thống cho VSync (Windows)
	OS.vsync_via_compositor = false
	print("VSync qua Compositor: ", OS.is_vsync_via_compositor_enabled())

	# 14. OS.window_borderless - Loại bỏ viền cửa sổ
	OS.window_borderless = true
	print("Cửa sổ không viền: ", OS.get_borderless_window())

	# 15. OS.window_fullscreen - Chuyển sang chế độ toàn màn hình
	OS.window_fullscreen = false
	print("Chế độ toàn màn hình: ", OS.is_window_fullscreen())

	# 16. OS.window_maximized - Cửa sổ có đang phóng to?
	OS.window_maximized = false
	print("Cửa sổ đang phóng to: ", OS.is_window_maximized())

	# 17. OS.window_minimized - Cửa sổ có đang thu nhỏ?
	OS.window_minimized = false
	print("Cửa sổ đang thu nhỏ: ", OS.is_window_minimized())

	# 18. OS.window_per_pixel_transparency_enabled - Cho phép hiệu ứng trong suốt pixel
	if OS.has_feature("per_pixel_transparency"):
		OS.window_per_pixel_transparency_enabled = true
		print("Hiệu ứng trong suốt pixel: ", OS.get_window_per_pixel_transparency_enabled())
	else:
		print("Không hỗ trợ hiệu ứng trong suốt pixel trên nền tảng này.")

	# 19. OS.window_position - Vị trí cửa sổ so với góc trên trái màn hình
	OS.window_position = Vector2(100, 100)
	print("Vị trí cửa sổ: ", OS.get_window_position())

	# 20. OS.window_resizable - Cửa sổ có thể thay đổi kích thước?
	OS.window_resizable = false
	print("Cửa sổ có thể thay đổi kích thước: ", OS.is_window_resizable())

	# 21. OS.window_size - Kích thước cửa sổ hiện tại
	OS.window_size = Vector2(800, 600)
	print("Kích thước cửa sổ: ", OS.get_window_size())


#-----METHOD------

	# 1. OS.alert("message", "title") - Hiển thị hộp thoại cảnh báo
	OS.alert("Đây là một thông báo!", "Thông báo")

	# 2. OS.can_draw() - Kiểm tra xem có thể vẽ không
	print("Có thể vẽ không? ", OS.can_draw())

	# 3. OS.can_use_threads() - Kiểm tra có hỗ trợ đa luồng?
	print("Hỗ trợ đa luồng? ", OS.can_use_threads())

	# 4. OS.center_window() - Đưa cửa sổ về giữa màn hình
	OS.center_window()

	# 5. OS.close_midi_inputs() - Đóng đầu vào MIDI
	OS.close_midi_inputs()

	# 6. OS.crash("message") - Gây crash engine (chỉ dùng để test)
	# OS.crash("Lỗi giả lập!")

	# 7. OS.delay_msec(1000) - Dừng chương trình 1 giây
	OS.delay_msec(1000)

	# 8. OS.delay_usec(1000000) - Dừng 1 triệu micro giây = 1 giây
	OS.delay_usec(1000000)

	# 9. OS.dump_memory_to_file("memory.log") - Ghi log bộ nhớ (debug)
	OS.dump_memory_to_file("user://memory.log")

	# 10. OS.dump_resources_to_file("resources.log") - Ghi danh sách tài nguyên
	OS.dump_resources_to_file("user://resources.log")

	# 11. OS.execute("path", ["args"], blocking, output) - Chạy lệnh hệ thống
	var output = []
	var exit_code = OS.execute("ls", ["-l"], true, output)
	print("Kết quả lệnh ls: ", output)

	# 12. OS.find_scancode_from_string("Escape") - Tìm scancode từ chuỗi
	print("Scancode Escape: ", OS.find_scancode_from_string("Escape"))

	# 13. OS.get_audio_driver_count() - Số driver âm thanh khả dụng
	print("Số driver âm thanh: ", OS.get_audio_driver_count())

	# 14. OS.get_audio_driver_name(0) - Tên driver âm thanh thứ nhất
	print("Driver âm thanh đầu tiên: ", OS.get_audio_driver_name(0))

	# 15. OS.get_cache_dir() - Thư mục cache toàn cục
	print("Thư mục cache: ", OS.get_cache_dir())

	# 16. OS.get_cmdline_args() - Lấy tham số dòng lệnh
	print("Tham số dòng lệnh: ", OS.get_cmdline_args())

	# 17. OS.get_config_dir() - Thư mục cấu hình người dùng
	print("Thư mục config: ", OS.get_config_dir())

	# 18. OS.get_connected_midi_inputs() - Danh sách thiết bị MIDI
	print("Thiết bị MIDI kết nối: ", OS.get_connected_midi_inputs())

	# 19. OS.get_current_video_driver() - Driver đồ họa hiện tại
	print("Video driver hiện tại: ", OS.get_current_video_driver())

	# 20. OS.get_data_dir() - Thư mục dữ liệu toàn cục
	print("Thư mục data: ", OS.get_data_dir())

	# 21. OS.get_date() - Lấy ngày tháng (đã lỗi thời)
	# print(OS.get_date())

	# 22. OS.get_datetime() - Lấy ngày giờ (đã lỗi thời)
	# print(OS.get_datetime())

	# 23. OS.get_datetime_from_unix_time(1630000000) - Ngày giờ từ Unix time
	# print(OS.get_datetime_from_unix_time(1630000000))

	# 24. OS.get_display_cutouts() - Các khu vực cắt trên màn hình (Android)
	print("Display cutouts: ", OS.get_display_cutouts())

	# 25. OS.get_dynamic_memory_usage() - Bộ nhớ động đang dùng (debug)
	print("Bộ nhớ động: ", OS.get_dynamic_memory_usage())

	# 26. OS.get_environment("HOME") - Giá trị biến môi trường
	print("Biến môi trường HOME: ", OS.get_environment("HOME"))

	# 27. OS.get_executable_path() - Đường dẫn đến file thực thi
	print("Đường dẫn executable: ", OS.get_executable_path())

	# 28. OS.get_granted_permissions() - Quyền đã được cấp (Android)
	print("Quyền đã cấp: ", OS.get_granted_permissions())

	# 29. OS.get_ime_selection() - Vị trí con trỏ IME (macOS)
	# print(OS.get_ime_selection())

	# 30. OS.get_ime_text() - Văn bản IME đang nhập (macOS)
	# print(OS.get_ime_text())

	# 31. OS.get_latin_keyboard_variant() - Loại bàn phím Latin
	print("Loại bàn phím Latin: ", OS.get_latin_keyboard_variant())

	# 32. OS.get_locale() - Ngôn ngữ hệ thống theo locale đầy đủ
	print("Locale hệ thống: ", OS.get_locale())

	# 33. OS.get_locale_language() - Mã ngôn ngữ đơn giản
	print("Mã ngôn ngữ: ", OS.get_locale_language())

	# 34. OS.get_main_thread_id() - ID luồng chính
	print("ID luồng chính: ", OS.get_main_thread_id())

	# 35. OS.get_model_name() - Tên model thiết bị (iOS/Android)
	print("Tên model thiết bị: ", OS.get_model_name())

	# 36. OS.get_name() - Tên HĐH
	print("Tên hệ điều hành: ", OS.get_name())

	# 37. OS.get_native_handle() - Handle nội bộ cho plugin GDNative
	# print(OS.get_native_handle(OS.HANDLE_NATIVE_WINDOW))

	# 38. OS.get_power_percent_left() - % pin còn lại
	print("Pin còn lại (%): ", OS.get_power_percent_left())

	# 39. OS.get_power_seconds_left() - Thời lượng pin còn lại (giây)
	print("Pin còn lại (giây): ", OS.get_power_seconds_left())

	# 40. OS.get_power_state() - Trạng thái pin
	print("Trạng thái pin: ", OS.get_power_state())

	# 41. OS.get_process_id() - ID tiến trình
	print("ID tiến trình: ", OS.get_process_id())

	# 42. OS.get_processor_count() - Số lõi CPU
	print("Số lõi CPU: ", OS.get_processor_count())

	# 43. OS.get_processor_name() - Tên CPU
	print("Tên CPU: ", OS.get_processor_name())

	# 44. OS.get_real_window_size() - Kích thước cửa sổ có viền
	print("Kích thước thật cửa sổ: ", OS.get_real_window_size())

	# 45. OS.get_restart_on_exit_arguments() - Đối số khởi động lại
	print("Khởi động lại khi thoát: ", OS.get_restart_on_exit_arguments())

	# 46. OS.get_scancode_string(KEY_ESCAPE) - Tên phím từ scancode
	print("Tên phím từ scancode: ", OS.get_scancode_string(KEY_ESCAPE))

	# 47. OS.get_screen_count() - Số màn hình
	print("Số màn hình: ", OS.get_screen_count())

	# 48. OS.get_screen_dpi() - Độ phân giải DPI
	print("DPI màn hình: ", OS.get_screen_dpi())

	# 49. OS.get_screen_max_scale() - Tỷ lệ scale lớn nhất
	print("Scale tối đa: ", OS.get_screen_max_scale())

	# 50. OS.get_screen_position() - Vị trí màn hình
	print("Vị trí màn hình: ", OS.get_screen_position())

	# 51. OS.get_screen_refresh_rate() - Tần số quét
	print("Tần số quét: ", OS.get_screen_refresh_rate())

	# 52. OS.get_screen_scale() - Tỷ lệ scale màn hình
	print("Tỷ lệ scale: ", OS.get_screen_scale())

	# 53. OS.get_screen_size() - Kích thước màn hình
	print("Kích thước màn hình: ", OS.get_screen_size())

	# 54. OS.get_splash_tick_msec() - Thời gian hiển thị splash
	print("Thời gian splash: ", OS.get_splash_tick_msec())

	# 55. OS.get_static_memory_peak_usage() - Bộ nhớ tĩnh cao nhất (debug)
	print("Peak bộ nhớ tĩnh: ", OS.get_static_memory_peak_usage())

	# 56. OS.get_static_memory_usage() - Bộ nhớ tĩnh hiện tại (debug)
	print("Bộ nhớ tĩnh: ", OS.get_static_memory_usage())

	# 57. OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) - Thư mục hệ thống
	print("Thư mục tài liệu: ", OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))

	# 58. OS.get_system_time_msecs() - Thời gian hệ thống (ms)
	print("Thời gian hệ thống (ms): ", OS.get_system_time_msecs())

	# 59. OS.get_system_time_secs() - Thời gian hệ thống (s)
	print("Thời gian hệ thống (s): ", OS.get_system_time_secs())

	# 60. OS.get_tablet_driver_count() - Số driver tablet
	print("Số driver tablet: ", OS.get_tablet_driver_count())

	# 61. OS.get_tablet_driver_name(0) - Tên driver tablet
	print("Tên driver tablet: ", OS.get_tablet_driver_name(0))

	# 62. OS.get_thread_caller_id() - ID luồng hiện tại
	print("ID luồng hiện tại: ", OS.get_thread_caller_id())

	# 63. OS.get_ticks_msec() - Tick kể từ lúc bắt đầu (ms)
	print("Tick (ms): ", OS.get_ticks_msec())

	# 64. OS.get_ticks_usec() - Tick kể từ lúc bắt đầu (μs)
	print("Tick (μs): ", OS.get_ticks_usec())

	# 65. OS.get_time() - Lấy giờ hệ thống (đã lỗi thời)
	# print(OS.get_time())

	# 66. OS.get_time_zone_info() - Thông tin múi giờ
	print("Múi giờ: ", OS.get_time_zone_info())

	# 67. OS.get_unique_id() - ID duy nhất của thiết bị
	print("Unique ID: ", OS.get_unique_id())

	# 68. OS.get_unix_time() - Thời gian UNIX (s)
	print("UNIX time (s): ", OS.get_unix_time())

	# 69. OS.get_unix_time_from_datetime({"year": 2023}) - UNIX từ dict
	# print(OS.get_unix_time_from_datetime({"year": 2023}))

	# 70. OS.get_user_data_dir() - Thư mục user data
	print("User data dir: ", OS.get_user_data_dir())

	# 71. OS.get_video_driver_count() - Số driver video
	print("Số driver video: ", OS.get_video_driver_count())

	# 72. OS.get_video_driver_name(0) - Tên driver video
	print("Tên driver video: ", OS.get_video_driver_name(0))

	# 73. OS.get_virtual_keyboard_height() - Chiều cao bàn phím ảo
	print("Chiều cao bàn phím ảo: ", OS.get_virtual_keyboard_height())

	# 74. OS.get_window_safe_area() - Vùng an toàn của cửa sổ
	print("Vùng an toàn cửa sổ: ", OS.get_window_safe_area())

	# 75. OS.global_menu_add_item("_dock", "Item", 1, 0) - Thêm item menu dock
	# OS.global_menu_add_item("_dock", "Test Item", 1, 0)

	# 76. OS.global_menu_add_separator("_dock") - Thêm separator
	# OS.global_menu_add_separator("_dock")

	# 77. OS.global_menu_clear("_dock") - Xóa menu dock
	# OS.global_menu_clear("_dock")

	# 78. OS.global_menu_remove_item("_dock", 0) - Xóa item menu
	# OS.global_menu_remove_item("_dock", 0)

	# 79. OS.has_clipboard() - Có nội dung trong clipboard không?
	print("Clipboard có dữ liệu? ", OS.has_clipboard())

	# 80. OS.has_environment("HOME") - Biến môi trường tồn tại?
	print("Biến HOME tồn tại? ", OS.has_environment("HOME"))

	# 81. OS.has_feature("standalone") - Có tính năng standalone?
	print("Có feature standalone? ", OS.has_feature("standalone"))

	# 82. OS.has_touchscreen_ui_hint() - Có màn cảm ứng?
	print("Có màn cảm ứng? ", OS.has_touchscreen_ui_hint())

	# 83. OS.has_virtual_keyboard() - Có bàn phím ảo?
	print("Có bàn phím ảo? ", OS.has_virtual_keyboard())

	# 84. OS.hide_virtual_keyboard() - Ẩn bàn phím ảo
	OS.hide_virtual_keyboard()

	# 85. OS.is_debug_build() - Có phải build debug?
	print("Build debug? ", OS.is_debug_build())

	# 86. OS.is_ok_left_and_cancel_right() - Nút OK bên trái?
	print("OK bên trái Cancel bên phải? ", OS.is_ok_left_and_cancel_right())

	# 87. OS.is_process_running(pid) - Tiến trình đang chạy?
	# print(OS.is_process_running(1234))

	# 88. OS.is_restart_on_exit_set() - Sẽ khởi động lại khi thoát?
	print("Khởi động lại khi thoát? ", OS.is_restart_on_exit_set())

	# 89. OS.is_scancode_unicode(KEY_A) - Scancode có Unicode?
	print("Scancode có Unicode? ", OS.is_scancode_unicode(KEY_A))

	# 90. OS.is_stdout_verbose() - Có chạy chế độ verbose?
	print("Chế độ verbose? ", OS.is_stdout_verbose())

	# 91. OS.is_userfs_persistent() - user:// có lưu trữ không?
	print("user:// có lưu trữ không? ", OS.is_userfs_persistent())

	# 92. OS.is_window_always_on_top() - Cửa sổ luôn ở trên?
	print("Cửa sổ luôn trên? ", OS.is_window_always_on_top())

	# 93. OS.is_window_focused() - Cửa sổ đang tập trung?
	print("Cửa sổ đang tập trung? ", OS.is_window_focused())

	# 94. OS.keyboard_get_current_layout() - Layout bàn phím hiện tại
	print("Layout bàn phím hiện tại: ", OS.keyboard_get_current_layout())

	# 95. OS.keyboard_get_layout_count() - Số layout bàn phím
	print("Số layout bàn phím: ", OS.keyboard_get_layout_count())

	# 96. OS.keyboard_get_layout_language(0) - Ngôn ngữ layout bàn phím
	print("Ngôn ngữ layout bàn phím: ", OS.keyboard_get_layout_language(0))

	# 97. OS.keyboard_get_layout_name(0) - Tên layout bàn phím
	print("Tên layout bàn phím: ", OS.keyboard_get_layout_name(0))

	# 98. OS.keyboard_get_scancode_from_physical(KEY_A) - Phím vật lý sang scancode
	print("Phím vật lý sang scancode: ", OS.keyboard_get_scancode_from_physical(KEY_A))

	# 99. OS.keyboard_set_current_layout(0) - Đặt layout bàn phím
	OS.keyboard_set_current_layout(0)

	# 100. OS.kill(pid) - Giết tiến trình
	# OS.kill(1234)

	# 101. OS.move_to_trash("file.txt") - Di chuyển vào thùng rác
	# OS.move_to_trash(ProjectSettings.globalize_path("user://test.txt"))

	# 102. OS.move_window_to_foreground() - Đưa cửa sổ lên trước
	OS.move_window_to_foreground()

	# 103. OS.native_video_is_playing() - Video native có đang phát?
	print("Video native đang phát? ", OS.native_video_is_playing())

	# 104. OS.native_video_pause() - Tạm dừng video native
	# OS.native_video_pause()

	# 105. OS.native_video_play("video.mp4") - Phát video native
	# OS.native_video_play("res://video.mp4", 1.0, "", "")

	# 106. OS.native_video_stop() - Dừng video native
	# OS.native_video_stop()

	# 107. OS.native_video_unpause() - Tiếp tục video native
	# OS.native_video_unpause()

	# 108. OS.open_midi_inputs() - Mở đầu vào MIDI
	OS.open_midi_inputs()

	# 109. OS.print_all_resources() - In tất cả tài nguyên
	# OS.print_all_resources("resources.txt")

	# 110. OS.print_all_textures_by_size() - In texture theo kích thước
	# OS.print_all_textures_by_size()

	# 111. OS.print_resources_by_type(["Texture"]) - In theo loại
	# OS.print_resources_by_type(["Texture"])

	# 112. OS.print_resources_in_use() - In tài nguyên đang dùng
	# OS.print_resources_in_use()

	# 113. OS.read_string_from_stdin() - Đọc từ stdin
	# var input = OS.read_string_from_stdin()
	# print("Bạn vừa nhập: ", input)

	# 114. OS.request_attention() - Yêu cầu chú ý cửa sổ
	OS.request_attention()

	# 115. OS.request_permission("RECORD_AUDIO") - Yêu cầu quyền Android
	# OS.request_permission("RECORD_AUDIO")

	# 116. OS.request_permissions() - Yêu cầu tất cả quyền Android
	# OS.request_permissions()

	# 117. OS.set_environment("TEST", "VALUE") - Đặt biến môi trường
	OS.set_environment("TEST", "VALUE")

	# 118. OS.set_icon(Image) - Đặt icon cửa sổ
	# var img = load("res://icon.png")
	# OS.set_icon(img)

	# 119. OS.set_ime_active(true) - Bật IME
	# OS.set_ime_active(true)

	# 120. OS.set_ime_position(Vector2(100, 100)) - Đặt vị trí IME
	# OS.set_ime_position(Vector2(100, 100))

	# 121. OS.set_native_icon("icon.ico") - Đặt icon gốc
	# OS.set_native_icon("res://icon.ico")

	# 122. OS.set_restart_on_exit(true) - Khởi động lại khi thoát
	# OS.set_restart_on_exit(true, ["--reset"])

	# 123. OS.set_thread_name("MyThread") - Đặt tên luồng
	# OS.set_thread_name("Main Thread")

	# 124. OS.set_use_file_access_save_and_swap(true) - Lưu an toàn
	OS.set_use_file_access_save_and_swap(true)

	# 125. OS.set_window_always_on_top(true) - Luôn hiển thị trên cùng
	OS.set_window_always_on_top(true)

	# 126. OS.set_window_mouse_passthrough([]) - Cho phép chuột xuyên qua
	OS.set_window_mouse_passthrough([])

	# 127. OS.set_window_title("Game Title") - Đặt tiêu đề cửa sổ
	OS.set_window_title("Godot Game")

	# 128. OS.shell_open("https://godotengine.org ") - Mở đường dẫn
	# OS.shell_open("https://godotengine.org ")

	# 129. OS.show_virtual_keyboard() - Hiện bàn phím ảo
	# OS.show_virtual_keyboard()

	# 130. OS.show_virtual_keyboard_type() - Hiện bàn phím theo kiểu
	# OS.show_virtual_keyboard_type("", OS.VIRTUAL_KEYBOARD_TYPE_DEFAULT)

	# 131. OS.tts_get_voices() - Lấy danh sách giọng nói
	print("Giọng nói TTS: ", OS.tts_get_voices())

	# 132. OS.tts_get_voices_for_language("en") - Giọng theo ngôn ngữ
	print("Giọng tiếng Anh: ", OS.tts_get_voices_for_language("en"))

	# 133. OS.tts_is_paused() - TTS đang tạm dừng?
	print("TTS đang tạm dừng? ", OS.tts_is_paused())

	# 134. OS.tts_is_speaking() - TTS đang đọc?
	print("TTS đang đọc? ", OS.tts_is_speaking())

	# 135. OS.tts_pause() - Tạm dừng TTS
	# OS.tts_pause()

	# 136. OS.tts_resume() - Tiếp tục TTS
	# OS.tts_resume()

	# 137. OS.tts_set_utterance_callback(...) - Callback TTS
	# OS.tts_set_utterance_callback(OS.TTS_UTTERANCE_ENDED, self, "_on_tts_end")

	# 138. OS.tts_speak(...) - Đọc văn bản
	# OS.tts_speak("Xin chào, đây là lời chào từ TTS.", "voice01")

	# 139. OS.tts_stop() - Dừng TTS
	# OS.tts_stop()

