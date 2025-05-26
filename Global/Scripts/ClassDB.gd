extends Node2D

func _ready():
	var _class_name = "Node"  # Lớp cơ sở để kiểm tra

	# 1. ClassDB.class_exists(_class_name) - Kiểm tra xem lớp có tồn tại không?
	print("Lớp ", _class_name, " tồn tại? ", ClassDB.class_exists(_class_name))

	# 2. ClassDB.is_class_enabled(_class_name) - Kiểm tra xem lớp có được bật không?
	print("Lớp ", _class_name, " đang bật? ", ClassDB.is_class_enabled(_class_name))

	# 3. ClassDB.get_parent_class(_class_name) - Lấy lớp cha của lớp đã cho
	var parent_class = ClassDB.get_parent_class(_class_name)
	print("Cha của lớp ", _class_name, ": ", parent_class)

	# 4. ClassDB.is_parent_class(child_class, parent_class) - Kiểm tra quan hệ thừa kế
	print("Node có phải là con của Node?", ClassDB.is_parent_class("Node", "Node"))
	print("Node có phải là con của Reference?", ClassDB.is_parent_class("Node", "Reference"))

	# 5. ClassDB.get_inheriters_from_class(_class_name) - Lấy tất cả lớp kế thừa từ _class_name
	print("Các lớp kế thừa từ Object: ", ClassDB.get_inheriters_from_class("Object"))

	# 6. ClassDB.get_class_list() - Lấy danh sách tất cả lớp có sẵn
	var all_classes = ClassDB.get_class_list()
	print("Tổng số lớp: ", all_classes.size())

	# Chỉ in vài lớp đầu tiên để tránh quá tải console
	var sample_classes = []
	for i in range(min(10, all_classes.size())):  # Giới hạn 10 phần tử
		sample_classes.append(all_classes[i])
	print("Một số lớp: ", sample_classes)

	# 7. ClassDB.can_instance(_class_name) - Kiểm tra xem có thể tạo instance không?
	print("Có thể tạo instance của lớp Node không?", ClassDB.can_instance("Node"))
	print("Có thể tạo instance của lớp Math không?", ClassDB.can_instance("Math"))  # Không thể vì là class tĩnh

	# 8. ClassDB.instance(_class_name) - Tạo instance của lớp nếu có thể
	if ClassDB.can_instance(_class_name):
		var node_instance = ClassDB.instance(_class_name)
		print("Tạo instance thành công: ", node_instance)

	# 9. ClassDB.class_get_category(_class_name) - Lấy category của lớp (chỉ debug)
	print("Category của lớp Node: ", ClassDB.class_get_category(_class_name))

	# 10. ClassDB.class_get_property_list(_class_name, no_inheritance) - Danh sách thuộc tính
	var properties = ClassDB.class_get_property_list(_class_name)
	print("Thuộc tính của lớp Node: ", properties)

	# 11. ClassDB.class_get_method_list(_class_name, no_inheritance) - Danh sách phương thức
	var methods = ClassDB.class_get_method_list(_class_name)
	var method_names = []
	for m in methods:
		method_names.append(m["name"])
	print("Phương thức của lớp Node: ", method_names)

	# 12. ClassDB.class_get_signal_list(_class_name, no_inheritance) - Danh sách tín hiệu
	var signals = ClassDB.class_get_signal_list(_class_name)
	var signal_names = []
	for s in signals:
		signal_names.append(s["name"])
	print("Tín hiệu của lớp Node: ", signal_names)

	# 13. ClassDB.class_get_enum_list(_class_name, no_inheritance) - Danh sách các enum trong class
	var enums = ClassDB.class_get_enum_list(_class_name)
	var enum_names = []
	for e in enums:
		enum_names.append(e)
	print("Enum của lớp Node: ", enum_names)

	# 14. ClassDB.class_has_method(_class_name, method_name) - Kiểm tra phương thức tồn tại
	print("Có phương thức 'add_child' trong Node không? ", ClassDB.class_has_method(_class_name, "add_child"))

	# 15. ClassDB.class_has_signal(_class_name, signal_name) - Kiểm tra tín hiệu tồn tại
	print("Có tín hiệu 'ready' trong Node không? ", ClassDB.class_has_signal(_class_name, "ready"))

	# 16. ClassDB.class_has_integer_constant(_class_name, constant_name) - Kiểm tra hằng số
	print("Có hằng số 'NOTIFICATION_READY' trong Node không? ", ClassDB.class_has_integer_constant(_class_name, "NOTIFICATION_READY"))

	# 17. ClassDB.class_get_integer_constant(_class_name, constant_name) - Lấy giá trị hằng số
	print("Giá trị NOTIFICATION_READY: ", ClassDB.class_get_integer_constant(_class_name, "NOTIFICATION_READY"))

	# 18. ClassDB.class_get_integer_constant_enum(_class_name, constant_name) - Enum chứa hằng số
	print("NOTIFICATION_READY thuộc enum nào? ", ClassDB.class_get_integer_constant_enum(_class_name, "NOTIFICATION_READY"))

	# 19. ClassDB.class_get_integer_constant_list(_class_name, no_inheritance) - Danh sách hằng số nguyên
	var int_constants = ClassDB.class_get_integer_constant_list(_class_name)
	var int_constant_names = []
	for c in int_constants:
		int_constant_names.append(c)
	print("Danh sách hằng số nguyên của lớp Node: ", int_constant_names)

	# 20. ClassDB.class_has_enum(_class_name, enum_name) - Kiểm tra enum tồn tại
	print("Có enum 'TransformMode' trong Node không? ", ClassDB.class_has_enum(_class_name, "TransformMode"))

	# 21. ClassDB.class_get_enum_constants(_class_name, enum_name, no_inheritance) - Các giá trị trong enum
	var enum_constants = ClassDB.class_get_enum_constants(_class_name, "TransformMode")
	print("Hằng số trong enum 'TransformMode': ", enum_constants)

	# 22. ClassDB.class_get_property(instance, property_name) - Lấy giá trị thuộc tính từ object
	if ClassDB.can_instance(_class_name):
		var obj = ClassDB.instance(_class_name)
		ClassDB.class_get_property(obj, "name")

	# 23. ClassDB.class_set_property(instance, property_name, value) - Thiết lập giá trị thuộc tính
	if ClassDB.can_instance(_class_name):
		var obj = ClassDB.instance(_class_name)
		ClassDB.class_set_property(obj, "name", "TestNode")
		print("Sau khi đổi tên: ", ClassDB.class_get_property(obj, "name"))

	# 24. ClassDB.class_get_signal(_class_name, signal_name) - Lấy thông tin tín hiệu
	var signal_info = ClassDB.class_get_signal(_class_name, "ready")
	print("Thông tin tín hiệu 'ready': ", signal_info)
