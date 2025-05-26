# InputMap là một singleton quản lý các hành động đầu vào (InputEventAction) trong Godot Engine. 
# Thêm/xóa hành động,
# Gán/phím/biến cố (event) cho hành động,
# Kiểm tra xem sự kiện có thuộc về một hành động không,
# Điều chỉnh vùng chết (deadzone),
# Và tải lại từ cấu hình dự án (ProjectSettings).
extends Node

func _ready():
	# === 1. InputMap.add_action(action, deadzone) - Thêm một hành động mới với deadzone mặc định ===
	var action_name = "move_right"
	InputMap.add_action(action_name, 0.5)
	print("Đã thêm hành động: ", action_name)

	# === 2. InputMap.action_add_event(action, event) - Gán một InputEvent cho hành động ===
	var key_event = InputEventKey.new()
	key_event.scancode = KEY_RIGHT
	key_event.pressed = true
	InputMap.action_add_event(action_name, key_event)
	print("Gán phím RIGHT cho hành động: ", action_name)

	# === 3. InputMap.has_action(action) - Kiểm tra xem hành động đã tồn tại chưa? ===
	print("Hành động '", action_name, "' tồn tại?", InputMap.has_action(action_name))

	# === 4. InputMap.get_action_list(action) - Lấy danh sách InputEvent gán cho hành động ===
	var events = InputMap.get_action_list(action_name)
	print("Sự kiện gán cho '", action_name, "':")
	for e in events:
		print(" - ", e.as_text())

	# === 5. InputMap.action_has_event(action, event) - Kiểm tra một InputEvent có được gán cho hành động không? ===
	print("Phím RIGHT có thuộc hành động '", action_name, "' không?", InputMap.action_has_event(action_name, key_event))

	# === 6. InputMap.action_set_deadzone(action, deadzone) - Thiết lập deadzone cho hành động ===
	InputMap.action_set_deadzone(action_name, 0.8)
	print("Deadzone của '", action_name, "': ", InputMap.action_get_deadzone(action_name))

	# === 7. InputMap.action_get_deadzone(action) - Lấy giá trị deadzone hiện tại của hành động ===
	var current_deadzone = InputMap.action_get_deadzone(action_name)
	print("Deadzone hiện tại của '", action_name, "': ", current_deadzone)

	# === 8. InputMap.event_is_action(event, action, exact_match) - Kiểm tra xem một sự kiện có phải là hành động không? ===
	var test_event = InputEventKey.new()
	test_event.scancode = KEY_RIGHT
	test_event.pressed = true
	print("Sự kiện có phải là '", action_name, "' không?", InputMap.event_is_action(test_event, action_name, false))

	# === 9. InputMap.get_actions() - Lấy tất cả tên hành động hiện tại ===
	var all_actions = InputMap.get_actions()
	print("Tất cả các hành động hiện tại:")
	for a in all_actions:
		print(" - ", a)

	# === 10. InputMap.action_erase_event(action, event) - Xóa một InputEvent khỏi hành động ===
	InputMap.action_erase_event(action_name, key_event)
	print("Đã xóa phím RIGHT khỏi hành động '", action_name, "'")

	# === 11. InputMap.action_erase_events(action) - Xóa toàn bộ InputEvent khỏi hành động ===
	InputMap.action_erase_events(action_name)
	print("Đã xóa toàn bộ sự kiện khỏi hành động '", action_name, "'")

	# === 12. InputMap.erase_action(action) - Xóa toàn bộ hành động khỏi InputMap ===
	InputMap.erase_action(action_name)
	print("Đã xóa hành động '", action_name, "'")

	# === 13. InputMap.load_from_globals() - Tải lại tất cả hành động từ ProjectSettings.input_map ===
	InputMap.load_from_globals()
	print("Đã tải lại các hành động từ ProjectSettings.input_map")
