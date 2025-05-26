extends Node

func _ready():
	# Tạo một đối tượng HMACContext mới
	var ctx = HMACContext.new()
	
	# Chuẩn bị khóa và dữ liệu
	var key = "MySecretKey12345" # Khóa bí mật
	var msg_part1 = "This is a secret " # Phần 1 của thông điệp
	var msg_part2 = "message for HMAC" # Phần 2 của thông điệp
	
	# 1. Khởi tạo HMACContext với SHA256
	var err = ctx.start(HashingContext.HASH_SHA256, key.to_utf8())
	if err == OK:
		print("Bắt đầu HMACContext với SHA256 thành công!")
	else:
		print("Lỗi khi khởi tạo HMACContext: ", err)
	
	# 2. Cập nhật thông điệp - Phần 1
	err = ctx.update(msg_part1.to_utf8())
	if err == OK:
		print("Cập nhật phần 1 của thông điệp thành công!")
	else:
		print("Lỗi khi cập nhật phần 1: ", err)
	
	# 3. Cập nhật thông điệp - Phần 2
	err = ctx.update(msg_part2.to_utf8())
	if err == OK:
		print("Cập nhật phần 2 của thông điệp thành công!")
	else:
		print("Lỗi khi cập nhật phần 2: ", err)
	
	# 4. Hoàn thành và lấy kết quả HMAC
	var hmac = ctx.finish()
	if hmac.empty():
		print("HMAC thất bại, trả về mảng rỗng!")
	else:
		print("HMAC (hex): ", hmac.hex_encode())
	
	# 5. Thử khởi tạo lại trước khi gọi finish (sẽ thất bại)
	err = ctx.start(HashingContext.HASH_SHA256, key.to_utf8())
	if err != OK:
		print("Không thể khởi tạo lại trước khi finish: ", err)
	
	# 6. Khởi tạo lại HMACContext để kiểm tra tính tái sử dụng
	ctx = HMACContext.new()
	err = ctx.start(HashingContext.HASH_SHA256, key.to_utf8())
	if err == OK:
		print("Khởi tạo lại HMACContext thành công!")
	else:
		print("Lỗi khi khởi tạo lại HMACContext: ", err)
	
	# 7. Cập nhật lại toàn bộ thông điệp và kiểm tra kết quả
	var full_msg = (msg_part1 + msg_part2).to_utf8()
	err = ctx.update(full_msg)
	if err == OK:
		print("Cập nhật toàn bộ thông điệp thành công!")
	else:
		print("Lỗi khi cập nhật toàn bộ thông điệp: ", err)
	
	# 8. Hoàn thành và kiểm tra lại HMAC
	var hmac2 = ctx.finish()
	if hmac2.empty():
		print("HMAC thứ hai thất bại, trả về mảng rỗng!")
	else:
		print("HMAC thứ hai (hex): ", hmac2.hex_encode())
	
	# Kiểm tra xem HMAC của hai cách có khớp nhau không
	if hmac == hmac2:
		print("Kiểm tra HMAC: Hai kết quả HMAC khớp nhau!")
	else:
		print("Kiểm tra HMAC: Hai kết quả HMAC KHÔNG khớp nhau!")


# extends Node

# # Initialize HMACContext and Crypto (for validation)
# var ctx = HMACContext.new()
# var crypto = Crypto.new()
# const CHUNK_SIZE = 512

# func _ready():
# 	# Step 1: Prepare key and message
# 	var key = "SuperSecretKey12345678901234567890" # 32-byte key
# 	var message = "This is a secret message to be HMACed! It is split into chunks to demonstrate streaming."
# 	print("Original message: ", message)
# 	var message_bytes = message.to_utf8()
# 	var key_bytes = key.to_utf8()
	
# 	# Step 2: Compute HMAC for the message in chunks for all supported hash types
# 	for hash_type in [HashingContext.HASH_SHA256, HashingContext.HASH_SHA1]:
# 		var hash_name = get_hash_type_name(hash_type)
# 		print("\nComputing ", hash_name, " HMAC for message:")
		
# 		# Start HMAC context
# 		var err = ctx.start(hash_type, key_bytes)
# 		if err == OK:
# 			print("Started ", hash_name, " HMAC context successfully")
# 		else:
# 			print("Failed to start ", hash_name, " HMAC context: ", err)
# 			continue
		
# 		# Update context with chunks
# 		var pos = 0
# 		while pos < message_bytes.size():
# 			var chunk = message_bytes.subarray(pos, min(pos + CHUNK_SIZE - 1, message_bytes.size() - 1))
# 			err = ctx.update(chunk)
# 			if err == OK:
# 				print("Updated ", hash_name, " HMAC context with chunk of size: ", chunk.size())
# 			else:
# 				print("Failed to update ", hash_name, " HMAC context: ", err)
# 				break
# 			pos += CHUNK_SIZE
		
# 		# Finish and get the HMAC
# 		var hmac = ctx.finish()
# 		if hmac.size() > 0:
# 			print(hash_name, " HMAC (hex): ", hmac.hex_encode())
# 			print(hash_name, " HMAC (array): ", Array(hmac))
# 		else:
# 			print("Failed to compute ", hash_name, " HMAC: Empty result")
		
# 		# Validate HMAC using Crypto.hmac_digest
# 		var crypto_hmac = crypto.hmac_digest(hash_type, key_bytes, message_bytes)
# 		if crypto_hmac == hmac:
# 			print(hash_name, " HMAC validated successfully against Crypto.hmac_digest")
# 		else:
# 			print(hash_name, " HMAC validation failed against Crypto.hmac_digest")
	
# 	# Step 3: Demonstrate empty HMAC failure case
# 	print("\nTesting HMAC failure case (calling finish without start):")
# 	var empty_hmac = ctx.finish() # Should return empty PoolByteArray
# 	if empty_hmac.size() == 0:
# 		print("Empty HMAC returned as expected when finish called without start")
# 	else:
# 		print("Unexpected non-empty HMAC result")

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
