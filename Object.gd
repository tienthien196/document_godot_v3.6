extends Node

# Hàm khởi tạo đầu tiên của đối tượng
func _init():
	print("1. Hàm _init(): Được gọi khi Object được khởi tạo.")

# Ghi đè phương thức _get_property_list để liệt kê các thuộc tính tùy chỉnh

# Ghi đè phương thức _get  để trả về giá trị của property tùy chỉnh
func _get(property):
	if property == "custom_property":
		return "Giá trị của custom_property"
	return null

# Ghi đè phương thức _set để thiết lập giá trị cho property tùy chỉnh
func _set(property, value):
	if property == "custom_property":
		print("Đã thiết lập giá trị cho custom_property = ", value)
		return true
	return false

# ---------------------Có thể gây ra memory leak--------------

# Ghi đè phương thức _to_string để thay đổi cách hiển thị object thành chuỗi
func _to_string():
	return "[ObjectCustom]"

# Hàm chính chạy thử nghiệm tất cả các method của Object
func _ready():
	var obj = preload("res://tienthien.gd").new() #tienthein extend Object
	

	# 2. call - Gọi phương thức từ xa
	obj.call("print_message", "Hello from call()")
	
	# 3. call_deferred - Gọi phương thức ở frame kế tiếp
	obj.call_deferred("print_message", "Hello from call_deferred()")

	# 4. callv - Gọi phương thức với mảng tham số
	obj.callv("print_message", ["Hello from callv()"])

	# 5. can_translate_messages - Kiểm tra xem có hỗ trợ dịch tin nhắn hay không
	print("5. can_translate_messages(): ", obj.can_translate_messages())


	# 1. add_user_signal - Thêm một tín hiệu do người dùng định nghĩa
	obj.add_user_signal("my_signal")
	obj.connect("my_signal", self, "_on_my_signal")
	print("2. add_user_signal('my_signal') + connect: Đã thêm tín hiệu tùy chỉnh và kết nối tới hàm '_on_my_signal'.")


	# 6. connect - Kết nối tín hiệu đến hàm
	obj.connect("my_signal", self, "_on_my_signal")
	print("6. connect('my_signal', self, '_on_my_signal'): Kết nối tín hiệu thành công.")

	# 7. disconnect - Ngắt kết nối tín hiệu
	obj.disconnect("my_signal", self, "_on_my_signal")
	print("7. disconnect('my_signal', self, '_on_my_signal'): Đã ngắt kết nối.")

	# 8. emit_signal - Phát tín hiệu
	obj.emit_signal("my_signal")
	print("8. emit_signal('my_signal'): Đã phát tín hiệu.")

	# 9. get - Lấy giá trị của thuộc tính
	print("9. get('custom_property'):", obj.get("custom_property"))

	# 10. get_class - Lấy tên lớp của đối tượng
	print("10. get_class():", obj.get_class())

	# 11. get_incoming_connections - Lấy danh sách các kết nối đến đối tượng
	print("11. get_incoming_connections():", obj.get_incoming_connections())

	# 12. get_indexed - Lấy giá trị theo đường dẫn thuộc tính
	obj.set("position:x", 100)
	print("12. get_indexed('position:x'):", obj.get_indexed("position:x"))

	# 13. get_instance_id - Lấy ID duy nhất của đối tượng
	print("13. get_instance_id():", obj.get_instance_id())

	# 14. get_meta - Lấy metadata
	obj.set_meta("author", "Nguyen Van A")
	print("14. get_meta('author'):", obj.get_meta("author"))

	# 15. get_method_list - Lấy danh sách các phương thức
	print("15. get_method_list():", obj.get_method_list())

	# 16. get_property_list - Lấy danh sách thuộc tính
	print("16. get_property_list():", obj.get_property_list())

	# 17. get_script - Lấy script đang gán
	print("17. get_script():", obj.get_script())

	# 18. get_signal_connection_list - Lấy danh sách kết nối của tín hiệu
	print("18. get_signal_connection_list('my_signal'):", obj.get_signal_connection_list("my_signal"))

	# 19. get_signal_list - Lấy danh sách tín hiệu
	print("19. get_signal_list():", obj.get_signal_list())

	# 20. has_meta - Kiểm tra tồn tại metadata
	print("20. has_meta('author'):", obj.has_meta("author"))

	# 21. has_method - Kiểm tra tồn tại phương thức
	print("21. has_method('print_message'):", obj.has_method("print_message"))

	# 22. has_signal - Kiểm tra tín hiệu tồn tại
	print("22. has_signal('my_signal'):", obj.has_signal("my_signal"))

	# 23. is_blocking_signals - Kiểm tra xem tín hiệu có bị chặn không
	obj.set_block_signals(true)
	print("23. is_blocking_signals():", obj.is_blocking_signals())

	# 24. is_class - Kiểm tra xem có phải là lớp cụ thể không
	print("24. is_class('Object'):", obj.is_class("Object"))

	# 25. is_connected - Kiểm tra xem tín hiệu đã được kết nối chưa
	print("25. is_connected('my_signal', self, '_on_my_signal'):", obj.is_connected("my_signal", self, "_on_my_signal"))

	# 26. notification - Gửi thông báo đến đối tượng
	obj.notification(Object.NOTIFICATION_POSTINITIALIZE)
	print("26. notification(NOTIFICATION_POSTINITIALIZE): Thông báo đã gửi.")

	# 27. property_list_changed_notify - Báo rằng danh sách thuộc tính đã thay đổi
	obj.property_list_changed_notify()
	print("27. property_list_changed_notify(): Đã cập nhật danh sách thuộc tính.")

	# 28. remove_meta - Xóa metadata
	obj.remove_meta("author")
	print("28. remove_meta('author'): Metadata 'author' đã bị xóa.")

	# 29. set - Thiết lập giá trị thuộc tính
	obj.set("custom_property", "Mới rồi nha!")
	print("29. set('custom_property', 'Mới rồi nha!')")

	# 30. set_block_signals - Chặn/tắt chặn tín hiệu
	obj.set_block_signals(false)
	print("30. set_block_signals(false): Tín hiệu đã được bật lại.")

	# 31. set_deferred - Thiết lập thuộc tính sau khi frame hiện tại hoàn tất
	obj.set_deferred("custom_property", "Set deferred rồi")
	print("31. set_deferred('custom_property', 'Set deferred rồi')")

	# 32. set_indexed - Thiết lập giá trị theo đường dẫn thuộc tính
	obj.set_indexed("position:y", 200)
	print("32. set_indexed('position:y', 200): Cập nhật vị trí y thành 200")

	# 33. set_message_translation - Bật/tắt dịch tin nhắn
	obj.set_message_translation(true)
	print("33. set_message_translation(true): Dịch tin nhắn đã được bật.")

	# 34. set_meta - Thiết lập metadata
	obj.set_meta("version", "1.0.0")
	print("34. set_meta('version', '1.0.0')")

	# 35. to_string - Chuyển đối tượng thành chuỗi
	print("35. to_string():", obj.to_string())

	# 36. tr - Dịch một chuỗi
	print("36. tr('Test translation'):", obj.tr("Test translation"))

	# 37. free - Giải phóng đối tượng khỏi bộ nhớ
	obj.free()
	print("37. free(): Đối tượng đã được giải phóng.")
	
	# Dừng tiến trình sau 3 giây để xem kết quả
	yield(get_tree().create_timer(3), "timeout")
	get_tree().quit()

# Hàm được gọi khi nhận tín hiệu my_signal
func _on_my_signal():
	print("=> Tín hiệu 'my_signal' đã được xử lý!")

# Hàm phụ để test call/callv/call_deferred
func print_message(msg):
	print("=> print_message: ", msg)
