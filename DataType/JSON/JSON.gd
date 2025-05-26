extends Node

func _ready():
	# === 1. JSON.parse(json_string) - Phân tích một chuỗi JSON ===
	var json_text = """{
		"name": "Nguyen Van A",
		"age": 25,
		"is_student": false,
		"hobbies": ["reading", "coding", "games"],
		"address": {
			"city": "Hanoi",
			"district": "Ba Dinh"
		}
	}"""
	

	# Gọi hàm parse
	var result = JSON.parse(json_text)

	# Kiểm tra lỗi phân tích
	if result.error == OK:
		print("Phân tích JSON thành công: ", result.result)
		var data = result.result  # Đây là Dictionary chứa dữ liệu đã parse
	else:
		print("Lỗi phân tích JSON tại dòng %d, cột %d: %s" % [result.error_line, result.error_column, result.error_str])
		return

	# === 2. JSON.print(value, indent, sort_keys) - Chuyển Variant thành chuỗi JSON ===

	# Tạo một Variant để chuyển sang JSON
	var save_data = {
		"name": "Nguyen Van A",
		"age": 25,
		"is_student": false,
		"hobbies": ["reading", "coding", "games"],
		"address": {
			"city": "Hanoi",
			"district": "Ba Dinh"
		}
	}

	# Chuyển thành chuỗi JSON có thụt lề và sắp xếp key
	var json_output = JSON.print(save_data, "  ", true)
	print("\nJSON sau khi in ra:")
	print(json_output)

	# === Thêm ví dụ về số nguyên/số thực ===
	var test_numbers = {
		"integer": 42,
		"float": 3.14,
		"negative": -100
	}

	var json_numbers = JSON.print(test_numbers)
	print("\nJSON với số nguyên và số thực:")
	print(json_numbers)
