extends Node

func _ready():
	# Tạo một đối tượng AESContext mới
	var aes = AESContext.new()
	
	# Chuẩn bị dữ liệu và khóa
	var khoa = "KhoaBiMat16Byte!" # Khóa 16 byte
	var du_lieu = "DuLieuBiMat16B!!" # Dữ liệu 16 byte (phải là bội số của 16)
	var iv = "VectorKhoiTao16B" # Vector khởi tạo 16 byte cho chế độ CBC
	
	# 1. Mã hóa và giải mã với chế độ ECB
	# 1.1. start (MODE_ECB_ENCRYPT): Bắt đầu mã hóa ECB
	var loi_bat_dau_ecb = aes.start(AESContext.MODE_ECB_ENCRYPT, khoa.to_utf8())
	if loi_bat_dau_ecb == OK:
		print("Bắt đầu mã hóa ECB thành công!")
	else:
		print("Lỗi khi bắt đầu mã hóa ECB: ", loi_bat_dau_ecb)
	
	# 1.2. update: Mã hóa dữ liệu
	var du_lieu_ma_hoa_ecb = aes.update(du_lieu.to_utf8())
	print("Dữ liệu mã hóa ECB: ", du_lieu_ma_hoa_ecb)
	
	# 1.3. finish: Kết thúc ngữ cảnh mã hóa ECB
	aes.finish()
	print("Đã kết thúc ngữ cảnh mã hóa ECB.")
	
	# 1.4. start (MODE_ECB_DECRYPT): Bắt đầu giải mã ECB
	loi_bat_dau_ecb = aes.start(AESContext.MODE_ECB_DECRYPT, khoa.to_utf8())
	if loi_bat_dau_ecb == OK:
		print("Bắt đầu giải mã ECB thành công!")
	else:
		print("Lỗi khi bắt đầu giải mã ECB: ", loi_bat_dau_ecb)
	
	# 1.5. update: Giải mã dữ liệu
	var du_lieu_giai_ma_ecb = aes.update(du_lieu_ma_hoa_ecb)
	print("Dữ liệu giải mã ECB: ", du_lieu_giai_ma_ecb)
	
	# 1.6. finish: Kết thúc ngữ cảnh giải mã ECB
	aes.finish()
	print("Đã kết thúc ngữ cảnh giải mã ECB.")
	
	# Kiểm tra xem dữ liệu giải mã có khớp với dữ liệu gốc không
	if du_lieu_giai_ma_ecb == du_lieu.to_utf8():
		print("Kiểm tra ECB: Giải mã khớp với dữ liệu gốc!")
	else:
		print("Kiểm tra ECB: Giải mã KHÔNG khớp với dữ liệu gốc!")
	
	# 2. Mã hóa và giải mã với chế độ CBC
	# 2.1. start (MODE_CBC_ENCRYPT): Bắt đầu mã hóa CBC
	var loi_bat_dau_cbc = aes.start(AESContext.MODE_CBC_ENCRYPT, khoa.to_utf8(), iv.to_utf8())
	if loi_bat_dau_cbc == OK:
		print("Bắt đầu mã hóa CBC thành công!")
	else:
		print("Lỗi khi bắt đầu mã hóa CBC: ", loi_bat_dau_cbc)
	
	# 2.2. get_iv_state: Lấy trạng thái IV hiện tại
	var iv_trang_thai = aes.get_iv_state()
	print("Trạng thái IV trong mã hóa CBC: ", iv_trang_thai)
	
	# 2.3. update: Mã hóa dữ liệu
	var du_lieu_ma_hoa_cbc = aes.update(du_lieu.to_utf8())
	print("Dữ liệu mã hóa CBC: ", du_lieu_ma_hoa_cbc)
	
	# 2.4. finish: Kết thúc ngữ cảnh mã hóa CBC
	aes.finish()
	print("Đã kết thúc ngữ cảnh mã hóa CBC.")
	
	# 2.5. start (MODE_CBC_DECRYPT): Bắt đầu giải mã CBC
	loi_bat_dau_cbc = aes.start(AESContext.MODE_CBC_DECRYPT, khoa.to_utf8(), iv.to_utf8())
	if loi_bat_dau_cbc == OK:
		print("Bắt đầu giải mã CBC thành công!")
	else:
		print("Lỗi khi bắt đầu giải mã CBC: ", loi_bat_dau_cbc)
	
	# 2.6. get_iv_state: Lấy trạng thái IV hiện tại (trong giải mã)
	iv_trang_thai = aes.get_iv_state()
	print("Trạng thái IV trong giải mã CBC: ", iv_trang_thai)
	
	# 2.7. update: Giải mã dữ liệu
	var du_lieu_giai_ma_cbc = aes.update(du_lieu_ma_hoa_cbc)
	print("Dữ liệu giải mã CBC: ", du_lieu_giai_ma_cbc)
	
	# 2.8. finish: Kết thúc ngữ cảnh giải mã CBC
	aes.finish()
	print("Đã kết thúc ngữ cảnh giải mã CBC.")
	
	# Kiểm tra xem dữ liệu giải mã có khớp với dữ liệu gốc không
	if du_lieu_giai_ma_cbc == du_lieu.to_utf8():
		print("Kiểm tra CBC: Giải mã khớp với dữ liệu gốc!")
	else:
		print("Kiểm tra CBC: Giải mã KHÔNG khớp với dữ liệu gốc!")


# extends Node

# # Initialize AESContext
# var aes = AESContext.new()

# func _ready():
# 	# Step 1: Prepare key and data
# 	var key = "MySecretKey12345678901234567890" # 32-byte key (AES-256)
# 	var iv = "MySecretIV123456" # 16-byte initialization vector for CBC
# 	var data = "This is a secret message!" # Data to encrypt/decrypt
	
# 	# Ensure data is padded to a multiple of 16 bytes
# 	var padded_data = pad_data(data.to_utf8(), 16)
# 	print("Original data: ", data)
# 	print("Padded data (hex): ", padded_data.hex_encode())
	
# 	# Step 2: AES-ECB Encryption and Decryption
# 	# Start ECB encryption
# 	var err = aes.start(AESContext.MODE_ECB_ENCRYPT, key.to_utf8())
# 	if err == OK:
# 		print("Started AES-ECB encryption successfully")
# 	else:
# 		print("Failed to start AES-ECB encryption: ", err)
	
# 	# Encrypt data
# 	var encrypted_ecb = aes.update(padded_data)
# 	print("ECB encrypted data (hex): ", encrypted_ecb.hex_encode())
	
# 	# Finish the context
# 	aes.finish()
	
# 	# Start ECB decryption
# 	err = aes.start(AESContext.MODE_ECB_DECRYPT, key.to_utf8())
# 	if err == OK:
# 		print("Started AES-ECB decryption successfully")
# 	else:
# 		print("Failed to start AES-ECB decryption: ", err)
	
# 	# Decrypt data
# 	var decrypted_ecb = aes.update(encrypted_ecb)
# 	var decrypted_text_ecb = decrypted_ecb.get_string_from_utf8()
# 	print("ECB decrypted data: ", decrypted_text_ecb)
	
# 	# Finish the context
# 	aes.finish()
	
# 	# Verify ECB decryption (after removing padding)
# 	var unpadded_text_ecb = unpad_data(decrypted_ecb).get_string_from_utf8()
# 	if unpadded_text_ecb == data:
# 		print("ECB decryption successful: Data matches original")
# 	else:
# 		print("ECB decryption failed: Data does not match")
	
# 	# Step 3: AES-CBC Encryption and Decryption
# 	# Start CBC encryption
# 	err = aes.start(AESContext.MODE_CBC_ENCRYPT, key.to_utf8(), iv.to_utf8())
# 	if err == OK:
# 		print("Started AES-CBC encryption successfully")
# 	else:
# 		print("Failed to start AES-CBC encryption: ", err)
	
# 	# Get initial IV state
# 	var initial_iv = aes.get_iv_state()
# 	print("Initial IV state (CBC encryption, hex): ", initial_iv.hex_encode())
	
# 	# Encrypt data
# 	var encrypted_cbc = aes.update(padded_data)
# 	print("CBC encrypted data (hex): ", encrypted_cbc.hex_encode())
	
# 	# Get updated IV state after encryption
# 	var updated_iv_encrypt = aes.get_iv_state()
# 	print("Updated IV state after encryption (hex): ", updated_iv_encrypt.hex_encode())
	
# 	# Finish the context
# 	aes.finish()
	
# 	# Start CBC decryption
# 	err = aes.start(AESContext.MODE_CBC_DECRYPT, key.to_utf8(), iv.to_utf8())
# 	if err == OK:
# 		print("Started AES-CBC decryption successfully")
# 	else:
# 		print("Failed to start AES-CBC decryption: ", err)
	
# 	# Get initial IV state for decryption
# 	var initial_iv_decrypt = aes.get_iv_state()
# 	print("Initial IV state (CBC decryption, hex): ", initial_iv_decrypt.hex_encode())
	
# 	# Decrypt data
# 	var decrypted_cbc = aes.update(encrypted_cbc)
# 	var decrypted_text_cbc = decrypted_cbc.get_string_from_utf8()
# 	print("CBC decrypted data: ", decrypted_text_cbc)
	
# 	# Get updated IV state after decryption
# 	var updated_iv_decrypt = aes.get_iv_state()
# 	print("Updated IV state after decryption (hex): ", updated_iv_decrypt.hex_encode())
	
# 	# Finish the context
# 	aes.finish()
	
# 	# Verify CBC decryption (after removing padding)
# 	var unpadded_text_cbc = unpad_data(decrypted_cbc).get_string_from_utf8()
# 	if unpadded_text_cbc == data:
# 		print("CBC decryption successful: Data matches original")
# 	else:
# 		print("CBC decryption failed: Data does not match")

# # Helper function to pad data to a multiple of block_size (16 bytes for AES)
# func pad_data(data: PoolByteArray, block_size: int) -> PoolByteArray:
# 	var padding_length = block_size - (data.size() % block_size)
# 	if padding_length == block_size:
# 		padding_length = 0
# 	var padded_data = data
# 	for i in range(padding_length):
# 		padded_data.append(padding_length) # PKCS#7 padding
# 	return padded_data

# # Helper function to remove padding from data
# func unpad_data(data: PoolByteArray) -> PoolByteArray:
# 	if data.size() == 0:
# 		return data
# 	var padding_length = data[data.size() - 1]
# 	if padding_length > data.size() or padding_length == 0:
# 		return data # No valid padding
# 	var unpadded_data = data.subarray(0, data.size() - padding_length - 1)
# 	return unpadded_data
