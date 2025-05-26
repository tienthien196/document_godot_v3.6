extends Node

func _ready():
	# Tạo một đối tượng File mới
	var file = File.new()
	
	# 1. open: Mở file để ghi hoặc đọc
	var loi_mo = file.open("user://du_lieu_game.dat", File.WRITE)
	if loi_mo == OK:
		print("Mở file để ghi thành công!")
	else:
		print("Lỗi khi mở file để ghi: ", loi_mo)
	
	# 2. endian_swap: Thiết lập thuộc tính endian_swap
	file.set_endian_swap(true)
	var endian = file.get_endian_swap()
	print("Endian swap được bật: ", endian)
	file.set_endian_swap(false) # Đặt lại về mặc định
	
	# 3. store_8: Lưu số nguyên 8-bit
	file.store_8(255)
	print("Đã lưu số nguyên 8-bit: 255")
	
	# 4. store_16: Lưu số nguyên 16-bit
	file.store_16(65535)
	print("Đã lưu số nguyên 16-bit: 65535")
	
	# 5. store_32: Lưu số nguyên 32-bit
	file.store_32(4294967295)
	print("Đã lưu số nguyên 32-bit: 4294967295")
	
	# 6. store_64: Lưu số nguyên 64-bit
	file.store_64(-9223372036854775807)
	print("Đã lưu số nguyên 64-bit: -9223372036854775807")
	
	# 7. store_float: Lưu số thực 32-bit
	file.store_float(3.14)
	print("Đã lưu số thực 32-bit: 3.14")
	
	# 8. store_double: Lưu số thực 64-bit
	file.store_double(3.14159265359)
	print("Đã lưu số thực 64-bit: 3.14159265359")
	
	# 9. store_real: Lưu số thực (tương tự store_float)
	file.store_real(2.718)
	print("Đã lưu số thực: 2.718")
	
	# 10. store_string: Lưu chuỗi không có ký tự xuống dòng
	file.store_string("Xin chào, Godot!")
	print("Đã lưu chuỗi: Xin chào, Godot!")
	
	# 11. store_line: Lưu chuỗi với ký tự xuống dòng
	file.store_line("Đây là một dòng mới.")
	print("Đã lưu dòng: Đây là một dòng mới.")
	
	# 12. store_pascal_string: Lưu chuỗi ở định dạng Pascal
	file.store_pascal_string("Chuỗi Pascal")
	print("Đã lưu chuỗi Pascal: Chuỗi Pascal")
	
	# 13. store_buffer: Lưu mảng byte
	var mang_byte = PoolByteArray([65, 66, 67]) # ASCII: A, B, C
	file.store_buffer(mang_byte)
	print("Đã lưu mảng byte: ", mang_byte)
	
	# 14. store_csv_line: Lưu dòng CSV
	var mang_csv = PoolStringArray(["Tên", "Điểm", "Cấp"])
	file.store_csv_line(mang_csv, ",")
	print("Đã lưu dòng CSV: ", mang_csv)
	
	# 15. store_var: Lưu một Variant (ví dụ: Dictionary)
	var du_lieu = {"ten": "Người Chơi", "diem": 1000}
	file.store_var(du_lieu, false)
	print("Đã lưu Variant: ", du_lieu)
	
	# 16. flush: Ghi dữ liệu vào đĩa
	file.flush()
	print("Đã ghi dữ liệu vào đĩa.")
	
	# 17. close: Đóng file sau khi ghi
	file.close()
	print("Đã đóng file sau khi ghi.")
	
	# 18. open: Mở lại file để đọc
	var loi_mo_doc = file.open("user://du_lieu_game.dat", File.READ)
	if loi_mo_doc == OK:
		print("Mở file để đọc thành công!")
	else:
		print("Lỗi khi mở file để đọc: ", loi_mo_doc)
	
	# 19. is_open: Kiểm tra xem file có đang mở không
	var dang_mo = file.is_open()
	print("File đang mở: ", dang_mo)
	
	# 20. get_position: Lấy vị trí con trỏ
	var vi_tri = file.get_position()
	print("Vị trí con trỏ: ", vi_tri)
	
	# 21. get_len: Lấy kích thước file
	var kich_thuoc = file.get_len()
	print("Kích thước file (byte): ", kich_thuoc)
	
	# 22. get_8: Đọc số nguyên 8-bit
	var so_8 = file.get_8()
	print("Đọc số nguyên 8-bit: ", so_8)
	
	# 23. get_16: Đọc số nguyên 16-bit
	var so_16 = file.get_16()
	print("Đọc số nguyên 16-bit: ", so_16)
	
	# 24. get_32: Đọc số nguyên 32-bit
	var so_32 = file.get_32()
	print("Đọc số nguyên 32-bit: ", so_32)
	
	# 25. get_64: Đọc số nguyên 64-bit
	var so_64 = file.get_64()
	print("Đọc số nguyên 64-bit: ", so_64)
	
	# 26. get_float: Đọc số thực 32-bit
	var so_float = file.get_float()
	print("Đọc số thực 32-bit: ", so_float)
	
	# 27. get_double: Đọc số thực 64-bit
	var so_double = file.get_double()
	print("Đọc số thực 64-bit: ", so_double)
	
	# 28. get_real: Đọc số thực
	var so_real = file.get_real()
	print("Đọc số thực: ", so_real)
	
	# 29. get_as_text: Đọc toàn bộ file dưới dạng chuỗi
	file.seek(0) # Quay lại đầu file
	var noi_dung = file.get_as_text()
	print("Nội dung file dưới dạng chuỗi: ", noi_dung)
	
	# 30. get_line: Đọc một dòng
	file.seek(0) # Quay lại đầu file
	var dong = file.get_line()
	print("Đọc dòng: ", dong)
	
	# 31. get_pascal_string: Đọc chuỗi Pascal
	file.seek(0) # Quay lại đầu file
	file.seek(28) # Bỏ qua các số nguyên và số thực đã lưu
	var chuoi_pascal = file.get_pascal_string()
	print("Đọc chuỗi Pascal: ", chuoi_pascal)
	
	# 32. get_buffer: Đọc mảng byte
	file.seek(0)
	file.seek(28 + len("Chuỗi Pascal") + 1) # Bỏ qua dữ liệu trước
	var mang_byte_doc = file.get_buffer(3)
	print("Đọc mảng byte: ", mang_byte_doc)
	
	# 33. get_csv_line: Đọc dòng CSV
	file.seek(0)
	file.seek(28 + len("Chuỗi Pascal") + 1 + 3) # Bỏ qua dữ liệu trước
	var csv_doc = file.get_csv_line(",")
	print("Đọc dòng CSV: ", csv_doc)
	
	# 34. get_var: Đọc Variant
	file.seek(0)
	file.seek(28 + len("Chuỗi Pascal") + 1 + 3 + len("Tên,Điểm,Cấp\n")) # Bỏ qua dữ liệu trước
	var du_lieu_doc = file.get_var(false)
	print("Đọc Variant: ", du_lieu_doc)
	
	# 35. eof_reached: Kiểm tra xem con trỏ có vượt quá cuối file không
	var het_file = file.eof_reached()
	print("Đã đến cuối file: ", het_file)
	
	# 36. seek: Di chuyển con trỏ đến vị trí cụ thể
	file.seek(10)
	var vi_tri_moi = file.get_position()
	print("Di chuyển con trỏ đến vị trí: ", vi_tri_moi)
	
	# 37. seek_end: Di chuyển con trỏ đến cuối file
	file.seek_end()
	var vi_tri_cuoi = file.get_position()
	print("Vị trí con trỏ sau seek_end: ", vi_tri_cuoi)
	
	# 38. get_path: Lấy đường dẫn file
	var duong_dan = file.get_path()
	print("Đường dẫn file: ", duong_dan)
	
	# 39. get_path_absolute: Lấy đường dẫn tuyệt đối
	var duong_dan_tuyet_doi = file.get_path_absolute()
	print("Đường dẫn tuyệt đối: ", duong_dan_tuyet_doi)
	
	# 40. get_error: Lấy lỗi gần nhất
	var loi = file.get_error()
	print("Lỗi gần nhất: ", loi)
	
	# 41. file_exists: Kiểm tra xem file có tồn tại không
	var co_file = file.file_exists("user://du_lieu_game.dat")
	print("File 'du_lieu_game.dat' tồn tại: ", co_file)
	
	# 42. get_md5: Tính MD5 của file
	var md5 = file.get_md5("user://du_lieu_game.dat")
	print("MD5 của file: ", md5)
	
	# 43. get_sha256: Tính SHA-256 của file
	var sha256 = file.get_sha256("user://du_lieu_game.dat")
	print("SHA-256 của file: ", sha256)
	
	# 44. get_modified_time: Lấy thời gian sửa đổi file
	var thoi_gian_sua = file.get_modified_time("user://du_lieu_game.dat")
	if typeof(thoi_gian_sua) == TYPE_INT:
		var ngay_gio = OS.get_datetime_from_unix_time(thoi_gian_sua)
		print("Thời gian sửa đổi: ", ngay_gio)
	else:
		print("Lỗi khi lấy thời gian sửa đổi: ", thoi_gian_sua)
	
	# 45. open_compressed: Mở file nén
	var file_nen = File.new()
	var loi_mo_nen = file_nen.open_compressed("user://du_lieu_nen.dat", File.WRITE, File.COMPRESSION_ZSTD)
	if loi_mo_nen == OK:
		file_nen.store_string("Dữ liệu nén")
		file_nen.close()
		print("Mở và lưu file nén thành công!")
	else:
		print("Lỗi khi mở file nén: ", loi_mo_nen)
	
	# 46. open_encrypted: Mở file mã hóa với khóa
	var khoa = PoolByteArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
							17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])
	var file_ma_hoa = File.new()
	var loi_mo_ma_hoa = file_ma_hoa.open_encrypted("user://du_lieu_ma_hoa.dat", File.WRITE, khoa)
	if loi_mo_ma_hoa == OK:
		file_ma_hoa.store_string("Dữ liệu mã hóa")
		file_ma_hoa.close()
		print("Mở và lưu file mã hóa thành công!")
	else:
		print("Lỗi khi mở file mã hóa: ", loi_mo_ma_hoa)
	
	# 47. open_encrypted_with_pass: Mở file mã hóa với mật khẩu
	var file_pass = File.new()
	var mat_khau = "matkhaubimat"
	var loi_mo_pass = file_pass.open_encrypted_with_pass("user://du_lieu_pass.dat", File.WRITE, mat_khau)
	if loi_mo_pass == OK:
		file_pass.store_string("Dữ liệu mã hóa bằng mật khẩu")
		file_pass.close()
		print("Mở và lưu file mã hóa bằng mật khẩu thành công!")
	else:
		print("Lỗi khi mở file mã hóa bằng mật khẩu: ", loi_mo_pass)
