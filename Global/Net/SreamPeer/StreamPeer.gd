extends Node

func _ready():
	# Tạo một StreamPeerBuffer để thử nghiệm
	var peer = StreamPeerBuffer.new()

	# Thiết lập big_endian (byte order)
	peer.big_endian = true
	print("Big Endian Enabled: ", peer.is_big_endian_enabled())

	# Ghi số nguyên có dấu
	peer.put_8(-100)
	peer.put_16(-10000)
	peer.put_32(-1000000000)
	peer.put_64(-1000000000000)

	# Ghi số nguyên không dấu
	peer.put_u8(200)
	peer.put_u16(50000)
	peer.put_u32(3000000000)
	peer.put_u64(18446744073709551615) # max u64

	# Ghi float và double
	peer.put_float(3.14)
	peer.put_double(1.234567890123456789)

	# Ghi chuỗi ASCII và UTF-8
	peer.put_string("Hello World")
	peer.put_utf8_string("Xin chào Việt Nam")

	# Ghi mảng byte tùy ý - đúng cách với PoolByteArray
	var data = PoolByteArray([72, 101, 108, 108, 111]) # "Hello"
	var error = peer.put_data(data)
	if error == OK:
		print("Data sent successfully.")
	else:
		print("Error sending data.")

	# Ghi Variant (Serializable data)
	var dict = {"name": "Alice", "age": 25}
	peer.put_var(dict, false)

	# Bây giờ đọc lại toàn bộ dữ liệu đã ghi
	print("\n--- Reading back data ---\n")

	# Đặt lại vị trí đọc về đầu buffer
	peer.seek(0)


	
	# Đọc số nguyên có dấu
	print("get_8: ", peer.get_8())        # -100
	print("get_16: ", peer.get_16())      # -10000
	print("get_32: ", peer.get_32())      # -1000000000
	print("get_64: ", peer.get_64())      # -1000000000000

	# Đọc số nguyên không dấu
	print("get_u8: ", peer.get_u8())      # 200
	print("get_u16: ", peer.get_u16())    # 50000
	print("get_u32: ", peer.get_u32())    # 3000000000
	print("get_u64: ", peer.get_u64())    # 18446744073709551615

	# Đọc float và double
	print("get_float: ", peer.get_float())     # ~3.14
	print("get_double: ", peer.get_double())   # ~1.234567890123456789

	# Đọc chuỗi ASCII
	print("get_string: ", peer.get_string())   # Hello World

	# Đọc chuỗi UTF-8
	print("get_utf8_string: ", peer.get_utf8_string())  # Xin chào Việt Nam

	# Đọc mảng byte
	var available_bytes = peer.get_available_bytes()
	print("Available bytes before get_data: ", available_bytes)


    # Đọc Variant
	var variant = peer.get_var()
	print("get_var: ", variant)  # {"name":"Alice", "age":25}

	
	var result = peer.get_data(5)  # Trả về [error, data]
	if result[0] == OK:
		var read_data = result[1] as PoolByteArray
		print("get_data: ", read_data.get_string_from_ascii())  # Hello
	else:
		print("Failed to read data.")

