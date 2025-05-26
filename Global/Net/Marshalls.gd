# Class Marshalls cung cấp các hàm tiện ích để biến đổi dữ liệu giữa các định dạng như:

# Biến Variant thành chuỗi Base64 và ngược lại.
# Mã hóa/giải mã Base64 từ/to PoolByteArray hoặc UTF-8 String.
# Rất hữu ích khi bạn cần:

# Gửi dữ liệu qua mạng,
# Lưu trữ dữ liệu đã được mã hóa,
# Truyền biến phức tạp dưới dạng chuỗi an toàn.

extends Node

func _ready():
	# === BIẾN ĐỔI TỪ BASE64 SANG DỮ LIỆU ===

	# 1. Marshalls.base64_to_raw(base64_str) - Chuyển Base64 sang PoolByteArray
	var base64_data = "SGVsbG8gd29ybGQh"  # "Hello world!" được mã hóa Base64
	var byte_array = Marshalls.base64_to_raw(base64_data)
	print("Base64 -> PoolByteArray: ", byte_array)

	# 2. Marshalls.base64_to_utf8(base64_str) - Chuyển Base64 sang UTF-8 string
	var decoded_string = Marshalls.base64_to_utf8(base64_data)
	print("Base64 -> UTF-8: ", decoded_string)

	# 3. Marshalls.base64_to_variant(base64_str, allow_objects) - Chuyển Base64 sang Variant (bao gồm object nếu cho phép)
	var variant_data_base64 = "CgAAAAEAAABlAAAADQAAAGZvbwBkAAAABQAAAGJhcmJiAAAAAw=="
	var decoded_variant = Marshalls.base64_to_variant(variant_data_base64, false)
	print("Base64 -> Variant: ", decoded_variant)

	# === BIẾN ĐỔI TỪ DỮ LIỆU SANG BASE64 ===

	# 4. Marshalls.raw_to_base64(array) - Chuyển PoolByteArray sang Base64
	var raw_bytes = PoolByteArray([72, 101, 108, 108, 111])  # "Hell" được mã hóa dưới dạng bytes
	var encoded_base64 = Marshalls.raw_to_base64(raw_bytes)
	print("PoolByteArray -> Base64: ", encoded_base64)

	# 5. Marshalls.utf8_to_base64(utf8_str) - Chuyển UTF-8 string sang Base64
	var utf8_text = "Xin chào thế giới!"
	var utf8_base64 = Marshalls.utf8_to_base64(utf8_text)
	print("UTF-8 -> Base64: ", utf8_base64)

	# 6. Marshalls.variant_to_base64(variant, full_objects) - Chuyển Variant sang Base64 (cho phép object nếu bật full_objects)
	var my_dict = {
		"name": "Nguyen Van A",
		"age": 25,
		"is_student": false
	}
	var variant_base64 = Marshalls.variant_to_base64(my_dict, false)
	print("Variant -> Base64: ", variant_base64)

	# === MINH HOẠ GIẢI MÃ LẠI DỮ LIỆU VỪA MÃ HÓA ===

	# Giải mã lại từ Base64 -> Variant
	var decoded_back = Marshalls.base64_to_variant(variant_base64, false)
	print("Giải mã Base64 về Variant: ", decoded_back)

	# Giải mã từ Base64 -> UTF-8
	var decoded_utf8 = Marshalls.base64_to_utf8(variant_base64)
	print("Giải mã Base64 về UTF-8: ", decoded_utf8)

	# Giải mã từ Base64 -> Raw PoolByteArray
	var decoded_raw = Marshalls.base64_to_raw(variant_base64)
	print("Giải mã Base64 về PoolByteArray: ", decoded_raw)

	# === VÍ DỤ VỀ OBJECT SERIALIZATION (nguy hiểm, chỉ dùng khi tin tưởng nguồn dữ liệu) ===

	# Tạo một object đơn giản
	var obj = preload("res://tienthien.gd").new()
	obj.name = "PlayerData"
	obj.health = 100

	# Mã hóa object thành Base64
	var obj_base64 = Marshalls.variant_to_base64(obj, true)  # Bật full_objects
	print("Object -> Base64 (full_objects): ", obj_base64)

	# Giải mã object trở lại (chỉ nên làm với dữ liệu đáng tin cậy)
	var decoded_obj = Marshalls.base64_to_variant(obj_base64, true)
	print("Base64 -> Object: ", decoded_obj)
