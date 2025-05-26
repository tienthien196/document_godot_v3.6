extends Node

func _ready():
    # === CẤU HÌNH CHUNG ===

    # 1. application/config/name - Tên dự án hiển thị trên title bar
    var project_name = ProjectSettings.get_setting("application/config/name")
    print("Tên dự án: ", project_name)

    # 2. application/config/icon - Đường dẫn icon của dự án
    var icon_path = ProjectSettings.get_setting("application/config/icon")
    print("Đường dẫn icon: ", icon_path)

    # 3. application/config/project_settings_override - File ghi đè cài đặt
    var override_file = ProjectSettings.get_setting("application/config/project_settings_override")
    print("File ghi đè cài đặt: ", override_file)

    # 4. application/config/use_custom_user_dir - Dùng thư mục người dùng tùy chỉnh
    var use_custom_user_dir = ProjectSettings.get_setting("application/config/use_custom_user_dir")
    print("Dùng thư mục người dùng tùy chỉnh? ", use_custom_user_dir)

    # 5. application/config/custom_user_dir_name - Tên thư mục người dùng tùy chỉnh
    var custom_user_dir = ProjectSettings.get_setting("application/config/custom_user_dir_name")
    print("Tên thư mục người dùng tùy chỉnh: ", custom_user_dir)

    # 6. application/config/use_hidden_project_data_directory - Dùng thư mục .import ẩn
    var hidden_data_dir = ProjectSettings.get_setting("application/config/use_hidden_project_data_directory")
    print("Dùng thư mục .import ẩn? ", hidden_data_dir)

    # 7. application/run/disable_stdout - Tắt in ra stdout
    var disable_stdout = ProjectSettings.get_setting("application/run/disable_stdout")
    print("Tắt in ra stdout? ", disable_stdout)

    # 8. application/run/disable_stderr - Tắt in lỗi ra stderr
    var disable_stderr = ProjectSettings.get_setting("application/run/disable_stderr")
    print("Tắt in lỗi ra stderr? ", disable_stderr)

    # 9. application/run/disable_stderr - Bật/tắt chế độ debug GDScript
    var enable_warnings = ProjectSettings.get_setting("debug/gdscript/warnings/enable")
    print("GDScript warnings bật không? ", enable_warnings)

    # 10. debug/settings/stdout/print_fps - In FPS ra console
    var print_fps = ProjectSettings.get_setting("debug/settings/stdout/print_fps")
    print("In FPS ra console không? ", print_fps)

    # 11. debug/settings/stdout/verbose_stdout - In thông tin chi tiết
    var verbose_stdout = ProjectSettings.get_setting("debug/settings/stdout/verbose_stdout")
    print("In thông tin chi tiết không? ", verbose_stdout)

    # 12. gui/common/swap_ok_cancel - Hoán đổi nút OK/Cancel
    var swap_ok_cancel = ProjectSettings.get_setting("gui/common/swap_ok_cancel")
    print("Hoán đổi nút OK/Cancel không? ", swap_ok_cancel)

    # 13. gui/theme/custom - Theme tùy chỉnh cho GUI
    var custom_theme = ProjectSettings.get_setting("gui/theme/custom")
    print("Đường dẫn theme tùy chỉnh: ", custom_theme)

    # 14. gui/theme/use_hidpi - Hỗ trợ HiDPI
    var use_hidpi = ProjectSettings.get_setting("gui/theme/use_hidpi")
    print("Bật hỗ trợ HiDPI không? ", use_hidpi)

    # 15. gui/timers/tooltip_delay_sec - Thời gian chờ tooltip
    var tooltip_delay = ProjectSettings.get_setting("gui/timers/tooltip_delay_sec")
    print("Thời gian chờ hiện tooltip (giây): ", tooltip_delay)

    # 16. physics/2d/physics_engine - Chọn engine vật lý 2D
    var phys_engine_2d = ProjectSettings.get_setting("physics/2d/physics_engine")
    print("Engine vật lý 2D đang dùng: ", phys_engine_2d)

    # 17. physics/2d/default_gravity - Gia tốc mặc định của trọng lực 2D
    var gravity_strength = ProjectSettings.get_setting("physics/2d/default_gravity")
    print("Gia tốc trọng lực 2D mặc định: ", gravity_strength)

    # 18. physics/2d/default_gravity_vector - Hướng trọng lực 2D
    var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
    print("Hướng trọng lực 2D: ", gravity_vector)

    # 19. physics/2d/sleep_threshold_linear - Ngưỡng ngủ tuyến tính
    var sleep_threshold_linear = ProjectSettings.get_setting("physics/2d/sleep_threshold_linear")
    print("Ngưỡng ngủ tuyến tính: ", sleep_threshold_linear)

    # 20. physics/2d/sleep_threshold_angular - Ngưỡng ngủ góc
    var sleep_threshold_angular = ProjectSettings.get_setting("physics/2d/sleep_threshold_angular")
    print("Ngưỡng ngủ góc: ", sleep_threshold_angular)

    # 21. physics/common/physics_fps - Số lần vật lý chạy mỗi giây
    var physics_fps = ProjectSettings.get_setting("physics/common/physics_fps")
    print("FPS vật lý: ", physics_fps)

    # 22. physics/common/enable_object_picking - Cho phép nhấp chọn vật lý 2D
    var enable_picking = ProjectSettings.get_setting("physics/common/enable_object_picking")
    print("Cho phép nhấp chọn vật lý 2D? ", enable_picking)

    # 23. physics/common/physics_interpolation - Kích hoạt nội suy vật lý
    var physics_interpolation = ProjectSettings.get_setting("physics/common/physics_interpolation")
    print("Kích hoạt nội suy vật lý? ", physics_interpolation)

    # 2d/cell_size - Kích thước ô lưới cho hiệu suất 2D
    var cell_size = ProjectSettings.get_setting("world/2d/cell_size")
    print("Kích thước ô lưới 2D: ", cell_size)

    # world/2d/execution_below_fps - Có xử lý vật lý khi FPS thấp?
    var exec_below_fps = ProjectSettings.get_setting("world/2d/execution_below_fps")
    print("Xử lý vật lý khi FPS thấp? ", exec_below_fps)

    # world/2d/padding_margin - Padding viền xung quanh cửa sổ
    var padding_margin = ProjectSettings.get_setting("world/2d/padding_margin")
    print("Padding viền cửa sổ: ", padding_margin)

    # gui/common/text_edit_undo_stack_max_size - Kích thước stack undo text edit
    var undo_stack_size = ProjectSettings.get_setting("gui/common/text_edit_undo_stack_max_size")
    print("Kích thước stack undo: ", undo_stack_size)

    # debug/settings/profiler/max_functions - Giới hạn hàm trong profiler
    var max_functions = ProjectSettings.get_setting("debug/settings/profiler/max_functions")
    print("Giới hạn hàm trong profiler: ", max_functions)

    # debug/settings/fps/force_fps - Buộc FPS cố định
    var force_fps = ProjectSettings.get_setting("debug/settings/fps/force_fps")
    print("Buộc FPS cố định: ", force_fps)

    # debug/settings/visual_script/max_call_stack - Stack tối đa trong Visual Scripting
    var vs_max_call_stack = ProjectSettings.get_setting("debug/settings/visual_script/max_call_stack")
    print("Stack tối đa cho Visual Scripting: ", vs_max_call_stack)

    # editor/script_templates_search_path - Thư mục chứa template script
    var script_template_path = ProjectSettings.get_setting("editor/script_templates_search_path")
    print("Thư mục template script: ", script_template_path)

    # logging/file_logging/enable_file_logging - Ghi log vào file
    var enable_log_file = ProjectSettings.get_setting("logging/file_logging/enable_file_logging")
    print("Ghi log vào file? ", enable_log_file)

    # logging/file_logging/log_path - Đường dẫn file log
    var log_path = ProjectSettings.get_setting("logging/file_logging/log_path")
    print("Đường dẫn file log: ", log_path)

    # debug/gdscript/completion/autocomplete_setters_and_getters - Autocomplete getter/setter
    var auto_complete = ProjectSettings.get_setting("debug/gdscript/completion/autocomplete_setters_and_getters")
    print("Autocomplete getter/setter? ", auto_complete)

    # debug/gdscript/warnings/exclude_addons - Loại cảnh báo ở res://addons
    var exclude_addon_warn = ProjectSettings.get_setting("debug/gdscript/warnings/exclude_addons")
    print("Loại cảnh báo ở res://addons? ", exclude_addon_warn)

    # debug/gdscript/warnings/enable - Bật tất cả cảnh báo GDScript
    var gdscript_warnings = ProjectSettings.get_setting("debug/gdscript/warnings/enable")
    print("Cảnh báo GDScript bật không? ", gdscript_warnings)

    # debug/settings/crash_handler/message - Thông điệp crash handler
    var crash_msg = ProjectSettings.get_setting("debug/settings/crash_handler/message")
    print("Thông điệp crash handler: ", crash_msg)

    # debug/settings/physics_interpolation/enable_warnings - Bật warning nội suy vật lý
    var enable_phys_interpolation_warning = ProjectSettings.get_setting("debug/settings/physics_interpolation/enable_warnings")
    print("Bật cảnh báo nội suy vật lý? ", enable_phys_interpolation_warning)

    # gui/common/text_edit_idle_detect_sec - Phát hiện nghỉ soạn thảo
    var idle_text_edit = ProjectSettings.get_setting("gui/timers/text_edit_idle_detect_sec")
    print("Phát hiện nghỉ soạn thảo sau (giây): ", idle_text_edit)

    # gui/common/version_string - Phiên bản trò chơi
    var version_str = ProjectSettings.get_setting("application/config/version")
    print("Phiên bản trò chơi: ", version_str)

    # gui/common/description - Mô tả trò chơi
    var description = ProjectSettings.get_setting("application/config/description")
    print("Mô tả trò chơi: ", description)

    # gui/common/texture_anisotropic_filter - Bộ lọc anisotropic cho texture
    var aniso_filter = ProjectSettings.get_setting("rendering/quality/texture_filters/anisotropic_filter")
    print("Bộ lọc anisotropic cho texture: ", aniso_filter)

    # render/threads/thread_model - Mô hình đa luồng
    var thread_model = ProjectSettings.get_setting("render/threads/thread_model")
    print("Mô hình đa luồng: ", thread_model)

    # audio/general/driver - Trình điều khiển âm thanh
    var audio_driver = ProjectSettings.get_setting("audio/general/driver")
    print("Trình điều khiển âm thanh: ", audio_driver)

    # input/ui_accept - Nút "chấp nhận" trong UI
    var ui_accept = ProjectSettings.get_setting("input/ui_accept")
    print("Nút chấp nhận trong UI: ", ui_accept)

    # input/ui_cancel - Nút "hủy" trong UI
    var ui_cancel = ProjectSettings.get_setting("input/ui_cancel")
    print("Nút hủy trong UI: ", ui_cancel)

    # input/ui_select - Nút chọn trong UI
    var ui_select = ProjectSettings.get_setting("input/ui_select")
    print("Nút chọn trong UI: ", ui_select)

    # input/ui_up - Nút lên trong UI
    var ui_up = ProjectSettings.get_setting("input/ui_up")
    print("Nút lên trong UI: ", ui_up)

    # input/ui_down - Nút xuống trong UI
    var ui_down = ProjectSettings.get_setting("input/ui_down")
    print("Nút xuống trong UI: ", ui_down)

    # input/ui_left - Nút trái trong UI
    var ui_left = ProjectSettings.get_setting("input/ui_left")
    print("Nút trái trong UI: ", ui_left)

    # input/ui_right - Nút phải trong UI
    var ui_right = ProjectSettings.get_setting("input/ui_right")
    print("Nút phải trong UI: ", ui_right)

    # input/ui_back - Nút back trong UI
    var ui_back = ProjectSettings.get_setting("input/ui_back")
    print("Nút back trong UI: ", ui_back)

    # input/ui_menu - Nút menu trong UI
    var ui_menu = ProjectSettings.get_setting("input/ui_menu")
    print("Nút menu trong UI: ", ui_menu)

    # input/enable_mouse_warp - Cho phép con trỏ chuột về giữa màn hình
    var enable_mouse_warp = ProjectSettings.get_setting("input/devices/enable_mouse_warp")
    print("Cho phép warp chuột không? ", enable_mouse_warp)

    # input/pointing/emulate_touch_from_mouse - Giả lập chạm từ chuột
    var emulate_touch = ProjectSettings.get_setting("input/pointing/emulate_touch_from_mouse")
    print("Giả lập chạm từ chuột không? ", emulate_touch)

    # display/window/stretch/mode - Chế độ stretch cửa sổ
    var stretch_mode = ProjectSettings.get_setting("display/window/stretch/mode")
    print("Chế độ stretch cửa sổ: ", stretch_mode)

    # display/window/stretch/aspect - Khía cạnh tỷ lệ stretch
    var stretch_aspect = ProjectSettings.get_setting("display/window/stretch/aspect")
    print("Khía cạnh tỷ lệ stretch: ", stretch_aspect)

    # display/window/stretch/use_integer_zoom - Zoom nguyên
    var integer_zoom = ProjectSettings.get_setting("display/window/stretch/use_integer_zoom")
    print("Zoom theo hệ số nguyên? ", integer_zoom)

    # display/window/handheld/display_subscreen - Hiển thị phụ màn hình di động
    var subscreen = ProjectSettings.get_setting("display/window/handheld/display_subscreen")
    print("Hiển thị phụ màn hình di động: ", subscreen)

    # display/window/handheld/orientation - Hướng màn hình di động
    var mobile_orient = ProjectSettings.get_setting("display/window/handheld/orientation")
    print("Hướng màn hình di động: ", mobile_orient)

    # display/window/handheld/vsync_to_texture - Đồng bộ hóa với texture (di động)
    var vsync_tex = ProjectSettings.get_setting("display/window/handheld/vsync_to_texture")
    print("VSync texture trên di động: ", vsync_tex)

    # display/window/per_pixel_transparency/enabled - Hiệu ứng trong suốt pixel
    var transparency_enabled = ProjectSettings.get_setting("display/window/per_pixel_transparency/enabled")
    print("Hiệu ứng trong suốt pixel bật không? ", transparency_enabled)

    # display/window/per_pixel_transparency/allowed - Cho phép trong suốt pixel
    var transparency_allowed = ProjectSettings.get_setting("display/window/per_pixel_transparency/allowed")
    print("Trong suốt pixel được cho phép? ", transparency_allowed)

    # display/window/subwindows/allow_drags - Cho phép kéo thả subwindow
    var allow_drag = ProjectSettings.get_setting("display/window/subwindows/allow_drags")
    print("Cho phép kéo thả subwindow? ", allow_drag)

    # display/window/subwindows/allow_reordering - Cho phép sắp xếp lại cửa sổ
    var allow_reorder = ProjectSettings.get_setting("display/window/subwindows/allow_reordering")
    print("Cho phép sắp xếp lại cửa sổ? ", allow_reorder)

    # display/window/subwindows/allow_input_passthrough - Chuột xuyên qua subwindow
    var input_passthrough = ProjectSettings.get_setting("display/window/subwindows/allow_input_passthrough")
    print("Cho phép chuột xuyên qua subwindow? ", input_passthrough)

    # display/window/subwindows/allow_close - Cho phép đóng subwindow
    var allow_close = ProjectSettings.get_setting("display/window/subwindows/allow_close")
    print("Cho phép đóng subwindow? ", allow_close)

    # display/window/subwindows/allow_resize - Cho phép resize subwindow
    var allow_resize = ProjectSettings.get_setting("display/window/subwindows/allow_resize")
    print("Cho phép resize subwindow? ", allow_resize)

    # display/window/subwindows/allow_minimize - Cho phép thu nhỏ subwindow
    var allow_minimize = ProjectSettings.get_setting("display/window/subwindows/allow_minimize")
    print("Cho phép thu nhỏ subwindow? ", allow_minimize)

    # display/window/subwindows/allow_maximize - Cho phép phóng to subwindow
    var allow_maximize = ProjectSettings.get_setting("display/window/subwindows/allow_maximize")
    print("Cho phép phóng to subwindow? ", allow_maximize)

    # display/window/subwindows/allow_move - Cho phép di chuyển subwindow
    var allow_move = ProjectSettings.get_setting("display/window/subwindows/allow_move")
    print("Cho phép di chuyển subwindow? ", allow_move)

    # display/window/subwindows/allow_focus - Cho phép focus subwindow
    var allow_focus = ProjectSettings.get_setting("display/window/subwindows/allow_focus")
    print("Cho phép focus subwindow? ", allow_focus)

    # display/window/subwindows/allow_raise - Cho phép nâng subwindow lên
    var allow_raise = ProjectSettings.get_setting("display/window/subwindows/allow_raise")
    print("Cho phép nâng subwindow lên? ", allow_raise)

    # display/window/subwindows/allow_keyboard_focus - Cho phép focus bàn phím
    var allow_kb_focus = ProjectSettings.get_setting("display/window/subwindows/allow_keyboard_focus")
    print("Cho phép focus bàn phím subwindow? ", allow_kb_focus)

    # display/window/subwindows/allow_close_on_escape - Đóng subwindow bằng Escape
    var close_on_esc = ProjectSettings.get_setting("display/window/subwindows/allow_close_on_escape")
    print("Cho phép đóng subwindow bằng Escape? ", close_on_esc)

    # display/window/subwindows/allow_window_pre_popup - Cho phép pop-up window
    var pre_popup = ProjectSettings.get_setting("display/window/subwindows/allow_window_pre_popup")
    print("Cho phép pop-up window? ", pre_popup)

    # display/window/subwindows/allow_window_open - Cho phép mở subwindow
    var window_open = ProjectSettings.get_setting("display/window/subwindows/allow_window_open")
    print("Cho phép mở subwindow? ", window_open)

    # display/window/subwindows/allow_window_resize - Cho phép resize subwindow
    var window_resize = ProjectSettings.get_setting("display/window/subwindows/allow_window_resize")
    print("Cho phép resize subwindow? ", window_resize)

    # display/window/subwindows/allow_window_move - Cho phép di chuyển subwindow
    var window_move = ProjectSettings.get_setting("display/window/subwindows/allow_window_move")
    print("Cho phép di chuyển subwindow? ", window_move)

    # display/window/subwindows/allow_window_close - Cho phép đóng subwindow
    var window_close = ProjectSettings.get_setting("display/window/subwindows/allow_window_close")
    print("Cho phép đóng subwindow? ", window_close)

    # display/window/subwindows/allow_window_minimize - Cho phép thu nhỏ subwindow
    var window_minimize = ProjectSettings.get_setting("display/window/subwindows/allow_window_minimize")
    print("Cho phép thu nhỏ subwindow? ", window_minimize)

    # display/window/subwindows/allow_window_maximize - Cho phép phóng to subwindow
    var window_maximize = ProjectSettings.get_setting("display/window/subwindows/allow_window_maximize")
    print("Cho phép phóng to subwindow? ", window_maximize)

    # display/window/subwindows/allow_window_focus - Cho phép focus subwindow
    var window_focus = ProjectSettings.get_setting("display/window/subwindows/allow_window_focus")
    print("Cho phép focus subwindow? ", window_focus)

    # display/window/subwindows/allow_window_keyboard_focus - Cho phép bàn phím subwindow
    var window_kb_focus = ProjectSettings.get_setting("display/window/subwindows/allow_window_keyboard_focus")
    print("Cho phép bàn phím subwindow? ", window_kb_focus)

    # display/window/subwindows/allow_window_close_on_escape - Đóng bằng Escape
    var window_esc = ProjectSettings.get_setting("display/window/subwindows/allow_window_close_on_escape")
    print("Cho phép đóng subwindow bằng Escape? ", window_esc)

    # display/window/subwindows/allow_window_pre_popup - Cho phép pop-up trước
    var window_prepopup = ProjectSettings.get_setting("display/window/subwindows/allow_window_pre_popup")
    print("Cho phép pop-up subwindow trước? ", window_prepopup)


