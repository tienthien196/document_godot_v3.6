extends Node

func _ready():
	# Tạo một đối tượng Crypto mới
	var crypto = Crypto.new()
	
	# 1. generate_rsa: Tạo khóa RSA 4096 bit
	var khoa = crypto.generate_rsa(4096)
	if khoa:
		print("Tạo khóa RSA 4096 bit thành công!")
	else:
		print("Lỗi khi tạo khóa RSA!")
	
	# Lưu khóa để sử dụng lại
	var loi_luu_khoa = khoa.save("user://khoa_rsa.key")
	if loi_luu_khoa == OK:
		print("Lưu khóa RSA vào user://khoa_rsa.key thành công!")
	else:
		print("Lỗi khi lưu khóa RSA: ", loi_luu_khoa)
	
	# 2. generate_self_signed_certificate: Tạo chứng chỉ tự ký
	var chung_chi = crypto.generate_self_signed_certificate(
		khoa,
		"CN=tròchơi.com,O=CôngTyGame,C=VN",
		"20250101000000", # Không hiệu lực trước ngày 01/01/2025
		"20350101000000"  # Hết hiệu lực sau ngày 01/01/2035
	)
	if chung_chi:
		print("Tạo chứng chỉ tự ký thành công!")
	else:
		print("Lỗi khi tạo chứng chỉ tự ký!")
	
	# Lưu chứng chỉ
	var loi_luu_chung_chi = chung_chi.save("user://chung_chi.crt")
	if loi_luu_chung_chi == OK:
		print("Lưu chứng chỉ vào user://chung_chi.crt thành công!")
	else:
		print("Lỗi khi lưu chứng chỉ: ", loi_luu_chung_chi)
	
	# 3. generate_random_bytes: Tạo mảng byte ngẫu nhiên an toàn
	var byte_ngau_nhien = crypto.generate_random_bytes(32)
	print("Mảng byte ngẫu nhiên (32 byte): ", byte_ngau_nhien)
	
	# 4. encrypt: Mã hóa dữ liệu bằng khóa công khai
	var du_lieu = "Dữ liệu bí mật cần mã hóa!"
	var du_lieu_utf8 = du_lieu.to_utf8()
	var du_lieu_ma_hoa = crypto.encrypt(khoa, du_lieu_utf8)
	print("Dữ liệu mã hóa: ", du_lieu_ma_hoa)
	
	# 5. decrypt: Giải mã dữ liệu bằng khóa riêng
	var du_lieu_giai_ma = crypto.decrypt(khoa, du_lieu_ma_hoa)
	print("Dữ liệu giải mã: ", du_lieu_giai_ma)
	
	# Kiểm tra xem dữ liệu giải mã có khớp với dữ liệu gốc không
	if du_lieu_giai_ma == du_lieu_utf8:
		print("Kiểm tra mã hóa/giải mã: Khớp với dữ liệu gốc!")
	else:
		print("Kiểm tra mã hóa/giải mã: KHÔNG khớp với dữ liệu gốc!")
	
	# 6. sign: Ký số dữ liệu bằng khóa riêng
	var hash_du_lieu = du_lieu.sha256_buffer() # Tạo hash SHA256 của dữ liệu
	var chu_ky = crypto.sign(HashingContext.HASH_SHA256, hash_du_lieu, khoa)
	print("Chữ ký số: ", chu_ky)
	
	# 7. verify: Xác minh chữ ký số bằng khóa công khai
	var xac_minh = crypto.verify(HashingContext.HASH_SHA256, hash_du_lieu, chu_ky, khoa)
	print("Xác minh chữ ký: ", "Thành công!" if xac_minh else "Thất bại!")
	
	# 8. hmac_digest: Tạo HMAC digest
	var khoa_hmac = crypto.generate_random_bytes(16) # Khóa HMAC 16 byte
	var hmac = crypto.hmac_digest(HashingContext.HASH_SHA256, khoa_hmac, du_lieu_utf8)
	print("HMAC digest (SHA256): ", hmac)
	
	# 9. constant_time_compare: So sánh hai mảng byte không để lộ thông tin thời gian
	var byte_goc = du_lieu_utf8
	var byte_so_sanh = du_lieu_utf8.duplicate() # Tạo bản sao để so sánh
	var ket_qua_so_sanh = crypto.constant_time_compare(byte_goc, byte_so_sanh)
	print("So sánh constant-time (giống nhau): ", "Thành công!" if ket_qua_so_sanh else "Thất bại!")
	
	# Thử so sánh với mảng byte khác
	var byte_khac = "Dữ liệu khác!!!".to_utf8()
	var ket_qua_so_sanh_khac = crypto.constant_time_compare(byte_goc, byte_khac)
	print("So sánh constant-time (khác nhau): ", "Thất bại!" if !ket_qua_so_sanh_khac else "Thành công!")

# extends Node

# # Initialize Crypto, CryptoKey, and X509Certificate
# var crypto = Crypto.new()
# var key = CryptoKey.new()
# var cert = X509Certificate.new()

# func _ready():
# 	# Step 1: Generate cryptographically secure random bytes
# 	var random_bytes = crypto.generate_random_bytes(32)
# 	print("Generated random bytes (32): ", random_bytes.hex_encode())
	
# 	# Step 2: Generate an RSA key pair
# 	var key_size = 2048 # Using 2048 bits for faster execution (4096 is more secure but slower)
# 	key = crypto.generate_rsa(key_size)
# 	print("Generated RSA key with size: ", key_size)
	
# 	# Save the key to a file
# 	var key_path = "user://crypto_example.key"
# 	var err = key.save(key_path)
# 	if err == OK:
# 		print("Saved key to: ", key_path)
# 	else:
# 		print("Failed to save key: ", err)
	
# 	# Step 3: Generate a self-signed certificate
# 	var issuer_name = "CN=mydomain.com,O=MyGameCompany,C=IT"
# 	var not_before = "20250101000000" # Valid from Jan 1, 2025
# 	var not_after = "20350101000000"  # Valid until Jan 1, 2035
# 	cert = crypto.generate_self_signed_certificate(key, issuer_name, not_before, not_after)
	
# 	# Save the certificate to a file
# 	var cert_path = "user://crypto_example.crt"
# 	err = cert.save(cert_path)
# 	if err == OK:
# 		print("Saved certificate to: ", cert_path)
# 	else:
# 		print("Failed to save certificate: ", err)
	
# 	# Step 4: Encrypt and decrypt data
# 	var data = "This is a secret message!"
# 	var plaintext = data.to_utf8() # Convert string to PoolByteArray
# 	var encrypted = crypto.encrypt(key, plaintext)
# 	print("Encrypted data: ", encrypted.hex_encode())
	
# 	var decrypted = crypto.decrypt(key, encrypted)
# 	var decrypted_text = decrypted.get_string_from_utf8()
# 	print("Decrypted data: ", decrypted_text)
	
# 	# Verify decryption
# 	if decrypted_text == data:
# 		print("Decryption successful: Data matches original")
# 	else:
# 		print("Decryption failed: Data does not match")
	
# 	# Step 5: Sign and verify data
# 	var hash_type = HashingContext.HASH_SHA256
# 	var data_hash = data.sha256_buffer() # Compute SHA-256 hash of data
# 	var signature = crypto.sign(hash_type, data_hash, key)
# 	print("Signature: ", signature.hex_encode())
	
# 	var verified = crypto.verify(hash_type, data_hash, signature, key)
# 	print("Signature verification: ", "Valid" if verified else "Invalid")
	
# 	# Step 6: Generate HMAC digest
# 	var hmac_key = crypto.generate_random_bytes(16) # Generate a 16-byte random key for HMAC
# 	var hmac = crypto.hmac_digest(hash_type, hmac_key, plaintext)
# 	print("HMAC digest (SHA-256): ", hmac.hex_encode())
	
# 	# Step 7: Constant-time comparison
# 	var trusted_bytes = crypto.generate_random_bytes(16)
# 	var received_bytes = trusted_bytes # Simulate receiving the same data
# 	var is_equal = crypto.constant_time_compare(trusted_bytes, received_bytes)
# 	print("Constant-time comparison (same bytes): ", "Equal" if is_equal else "Not equal")
	
# 	# Test with different bytes
# 	var different_bytes = crypto.generate_random_bytes(16)
# 	is_equal = crypto.constant_time_compare(trusted_bytes, different_bytes)
# 	print("Constant-time comparison (different bytes): ", "Equal" if is_equal else "Not equal")
	
# 	# Step 8: Demonstrate HMAC with SHA-1 (to showcase both supported hash types)
# 	var hmac_sha1 = crypto.hmac_digest(HashingContext.HASH_SHA1, hmac_key, plaintext)
# 	print("HMAC digest (SHA-1): ", hmac_sha1.hex_encode())
	
# 	# Step 9: Load key and certificate to verify persistence
# 	var loaded_key = CryptoKey.new()
# 	err = loaded_key.load(key_path)
# 	if err == OK:
# 		print("Loaded key successfully from: ", key_path)
# 	else:
# 		print("Failed to load key: ", err)
	
# 	var loaded_cert = X509Certificate.new()
# 	err = loaded_cert.load(cert_path)
# 	if err == OK:
# 		print("Loaded certificate successfully from: ", cert_path)
# 	else:
# 		print("Failed to load certificate: ", err)
	
# 	# Step 10: Verify loaded key by re-running encryption/decryption
# 	var encrypted_with_loaded_key = crypto.encrypt(loaded_key, plaintext)
# 	var decrypted_with_loaded_key = crypto.decrypt(loaded_key, encrypted_with_loaded_key)
# 	var decrypted_text_loaded = decrypted_with_loaded_key.get_string_from_utf8()
# 	print("Decrypted with loaded key: ", decrypted_text_loaded)
	
# 	if decrypted_text_loaded == data:
# 		print("Decryption with loaded key successful: Data matches original")
# 	else:
# 		print("Decryption with loaded key failed: Data does not match")
	
# 	# Step 11: Verify loaded key by re-running signing/verification
# 	var signature_with_loaded_key = crypto.sign(hash_type, data_hash, loaded_key)
# 	var verified_with_loaded_key = crypto.verify(hash_type, data_hash, signature_with_loaded_key, loaded_key)
# 	print("Signature verification with loaded key: ", "Valid" if verified_with_loaded_key else "Invalid")
