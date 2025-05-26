extends Node

const CHUNK_SIZE = 1024

func _ready():
	# Tạo một đối tượng HashingContext mới
	var ctx = HashingContext.new()
	
	# Chuẩn bị dữ liệu mẫu
	var message = "This is a secret message for hashing!"
	var message_chunks = [
		"This is a ",
		"secret message ",
		"for hashing!"
	]
	
	# 1. Tính toán hash cho chuỗi văn bản với các thuật toán khác nhau
	for hash_type in [HashingContext.HASH_MD5, HashingContext.HASH_SHA1, HashingContext.HASH_SHA256]:
		# 1.1. Khởi tạo HashingContext
		var err = ctx.start(hash_type)
		if err == OK:
			print("Bắt đầu HashingContext với ", get_hash_type_name(hash_type), " thành công!")
		else:
			print("Lỗi khi khởi tạo HashingContext với ", get_hash_type_name(hash_type), ": ", err)
			continue
		
		# 1.2. Cập nhật từng phần của chuỗi
		for chunk in message_chunks:
			err = ctx.update(chunk.to_utf8())
			if err == OK:
				print("Cập nhật phần dữ liệu với ", get_hash_type_name(hash_type), " thành công!")
			else:
				print("Lỗi khi cập nhật dữ liệu với ", get_hash_type_name(hash_type), ": ", err)
		
		# 1.3. Hoàn thành và lấy kết quả hash
		var hash_result = ctx.finish()
		if hash_result.empty():
			print("Hash với ", get_hash_type_name(hash_type), " thất bại, trả về mảng rỗng!")
		else:
			print("Hash với ", get_hash_type_name(hash_type), " (hex): ", hash_result.hex_encode())
			print("Hash với ", get_hash_type_name(hash_type), " (array): ", Array(hash_result))
	
	# 2. Tính toán hash cho một "tệp" giả lập
	var file_content = "This is a simulated file content for hashing.\nIt has multiple lines.\nFor testing purposes."
	var file_chunks = []
	var index = 0
	while index < file_content.length():
		file_chunks.append(file_content.substr(index, CHUNK_SIZE))
		index += CHUNK_SIZE
	
	# 2.1. Khởi tạo lại HashingContext với SHA256
	var err = ctx.start(HashingContext.HASH_SHA256)
	if err == OK:
		print("Bắt đầu HashingContext cho tệp giả lập với SHA256 thành công!")
	else:
		print("Lỗi khi khởi tạo HashingContext cho tệp giả lập: ", err)
		return
	
	# 2.2. Cập nhật từng phần của "tệp"
	for chunk in file_chunks:
		err = ctx.update(chunk.to_utf8())
		if err == OK:
			print("Cập nhật phần dữ liệu tệp giả lập thành công!")
		else:
			print("Lỗi khi cập nhật dữ liệu tệp giả lập: ", err)
	
	# 2.3. Hoàn thành và lấy kết quả hash cho tệp
	var file_hash = ctx.finish()
	if file_hash.empty():
		print("Hash tệp giả lập thất bại, trả về mảng rỗng!")
	else:
		print("Hash tệp giả lập với SHA256 (hex): ", file_hash.hex_encode())
		print("Hash tệp giả lập với SHA256 (array): ", Array(file_hash))
	
	# 2.4. Kiểm tra tính toàn vẹn bằng cách tính lại hash
	ctx = HashingContext.new()
	err = ctx.start(HashingContext.HASH_SHA256)
	if err == OK:
		err = ctx.update(file_content.to_utf8())
		if err == OK:
			var file_hash_check = ctx.finish()
			if file_hash == file_hash_check:
				print("Kiểm tra hash tệp: Kết quả khớp với hash ban đầu!")
			else:
				print("Kiểm tra hash tệp: Kết quả KHÔNG khớp với hash ban đầu!")
		else:
			print("Lỗi khi cập nhật toàn bộ dữ liệu tệp: ", err)
	else:
		print("Lỗi khi khởi tạo lại HashingContext: ", err)

# Hàm hỗ trợ để lấy tên của loại hash
func get_hash_type_name(hash_type):
	match hash_type:
		HashingContext.HASH_MD5:
			return "MD5"
		HashingContext.HASH_SHA1:
			return "SHA1"
		HashingContext.HASH_SHA256:
			return "SHA256"
		_:
			return "Unknown"


# extends Node

# # Initialize HashingContext
# var ctx = HashingContext.new()
# const CHUNK_SIZE = 1024

# func _ready():
# 	# Step 1: Create a sample file to hash
# 	var file_path = "user://sample_file.txt"
# 	create_sample_file(file_path)
	
# 	# Step 2: Hash a string in chunks for all hash types
# 	var data = "This is a sample text for hashing! It is processed in chunks to demonstrate iterative hashing."
# 	print("Original data: ", data)
# 	var data_bytes = data.to_utf8()
	
# 	# Process all supported hash types
# 	for hash_type in [HashingContext.HASH_MD5, HashingContext.HASH_SHA1, HashingContext.HASH_SHA256]:
# 		var hash_name = get_hash_type_name(hash_type)
# 		print("\nComputing ", hash_name, " hash for string:")
		
# 		# Start hashing context
# 		var err = ctx.start(hash_type)
# 		if err == OK:
# 			print("Started ", hash_name, " context successfully")
# 		else:
# 			print("Failed to start ", hash_name, " context: ", err)
# 			continue
		
# 		# Update context with chunks
# 		var pos = 0
# 		while pos < data_bytes.size():
# 			var chunk = data_bytes.subarray(pos, min(pos + CHUNK_SIZE - 1, data_bytes.size() - 1))
# 			err = ctx.update(chunk)
# 			if err == OK:
# 				print("Updated ", hash_name, " context with chunk of size: ", chunk.size())
# 			else:
# 				print("Failed to update ", hash_name, " context: ", err)
# 			pos += CHUNK_SIZE
		
# 		# Finish and get the hash
# 		var hash_result = ctx.finish()
# 		print(hash_name, " hash (hex): ", hash_result.hex_encode())
# 		print(hash_name, " hash (array): ", Array(hash_result))
	
# 	# Step 3: Hash a file for all hash types
# 	print("\nHashing file: ", file_path)
# 	for hash_type in [HashingContext.HASH_MD5, HashingContext.HASH_SHA1, HashingContext.HASH_SHA256]:
# 		var hash_name = get_hash_type_name(hash_type)
# 		var file_hash = hash_file(file_path, hash_type)
# 		if file_hash != null:
# 			print(hash_name, " hash for file (hex): ", file_hash.hex_encode())
# 			print(hash_name, " hash for file (array): ", Array(file_hash))
# 		else:
# 			print("Failed to compute ", hash_name, " hash for file")

# # Helper function to create a sample file for hashing
# func create_sample_file(path: String):
# 	var file = File.new()
# 	var err = file.open(path, File.WRITE)
# 	if err != OK:
# 		print("Failed to create sample file: ", err)
# 		return
# 	var sample_content = "This is a sample file content for hashing.\n" + \
# 						"It contains multiple lines to simulate a larger file.\n" + \
# 						"HashingContext will process it in chunks."
# 	file.store_string(sample_content)
# 	file.close()
# 	print("Created sample file at: ", path)

# # Helper function to hash a file
# func hash_file(path: String, hash_type: int):
# 	var file = File.new()
# 	var hash_name = get_hash_type_name(hash_type)
	
# 	# Check if file exists
# 	if not file.file_exists(path):
# 		print("File does not exist: ", path)
# 		return null
	
# 	# Start hashing context
# 	var err = ctx.start(hash_type)
# 	if err != OK:
# 		print("Failed to start ", hash_name, " context for file: ", err)
# 		return null
	
# 	# Open the file
# 	err = file.open(path, File.READ)
# 	if err != OK:
# 		print("Failed to open file ", path, ": ", err)
# 		return null
	
# 	# Update context with chunks
# 	while not file.eof_reached():
# 		var chunk = file.get_buffer(CHUNK_SIZE)
# 		if chunk.size() > 0: # Only update if chunk is non-empty
# 			err = ctx.update(chunk)
# 			if err != OK:
# 				print("Failed to update ", hash_name, " context for file: ", err)
# 				file.close()
# 				return null
	
# 	# Finish and get the hash
# 	var hash_result = ctx.finish()
# 	file.close()
# 	return hash_result

# # Helper function to get the name of the hash type
# func get_hash_type_name(hash_type: int) -> String:
# 	match hash_type:
# 		HashingContext.HASH_MD5:
# 			return "MD5"
# 		HashingContext.HASH_SHA1:
# 			return "SHA-1"
# 		HashingContext.HASH_SHA256:
# 			return "SHA-256"
# 		_:
# 			return "Unknown"
