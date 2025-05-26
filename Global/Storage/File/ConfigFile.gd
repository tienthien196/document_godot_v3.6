extends Node

func _ready():
	# Tạo một đối tượng ConfigFile mới
	var config = ConfigFile.new()
	
	# 1. set_value: Lưu trữ các giá trị thuộc nhiều kiểu dữ liệu khác nhau
	config.set_value("NguoiChoi", "ten", "AnhHung") # Lưu tên người chơi
	config.set_value("NguoiChoi", "diem", 1000) # Lưu điểm số
	config.set_value("NguoiChoi", "vi_tri", Vector2(100, 200)) # Lưu vị trí
	config.set_value("CaiDat", "am_luong", 0.8) # Lưu cài đặt âm lượng
	config.set_value("CaiDat", "toan_man_hinh", true) # Lưu chế độ toàn màn hình
	config.set_value("KhoDo", "vat_pham", ["kiem", "khieng", "thuoc"]) # Lưu danh sách vật phẩm
	
	# 2. save: Lưu cấu hình vào file thông thường (.cfg)
	var loi_luu = config.save("user://cau_hinh_game.cfg")
	if loi_luu == OK:
		print("Lưu file cấu hình thành công!")
	else:
		print("Lỗi khi lưu file cấu hình: ", loi_luu)
	
	# 3. save_encrypted: Lưu file mã hóa với khóa AES-256
	var khoa = PoolByteArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
							17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])
	var loi_luu_ma_hoa = config.save_encrypted("user://cau_hinh_ma_hoa.cfg", khoa)
	if loi_luu_ma_hoa == OK:
		print("Lưu file mã hóa thành công!")
	else:
		print("Lỗi khi lưu file mã hóa: ", loi_luu_ma_hoa)
	
	# 4. save_encrypted_pass: Lưu file mã hóa với mật khẩu
	var mat_khau = "matkhaubimat"
	var loi_luu_pass = config.save_encrypted_pass("user://cau_hinh_pass.cfg", mat_khau)
	if loi_luu_pass == OK:
		print("Lưu file mã hóa bằng mật khẩu thành công!")
	else:
		print("Lỗi khi lưu file mã hóa bằng mật khẩu: ", loi_luu_pass)
	
	# Tạo đối tượng ConfigFile mới để tải dữ liệu
	var config_tai = ConfigFile.new()
	
	# 5. load: Tải file cấu hình thông thường
	var loi_tai = config_tai.load("user://cau_hinh_game.cfg")
	if loi_tai == OK:
		print("Tải file cấu hình thành công!")
	else:
		print("Lỗi khi tải file cấu hình: ", loi_tai)
	
	# 6. load_encrypted: Tải file mã hóa với khóa
	var loi_tai_ma_hoa = config_tai.load_encrypted("user://cau_hinh_ma_hoa.cfg", khoa)
	if loi_tai_ma_hoa == OK:
		print("Tải file mã hóa thành công!")
	else:
		print("Lỗi khi tải file mã hóa: ", loi_tai_ma_hoa)
	
	# 7. load_encrypted_pass: Tải file mã hóa với mật khẩu
	var loi_tai_pass = config_tai.load_encrypted_pass("user://cau_hinh_pass.cfg", mat_khau)
	if loi_tai_pass == OK:
		print("Tải file mã hóa bằng mật khẩu thành công!")
	else:
		print("Lỗi khi tải file mã hóa bằng mật khẩu: ", loi_tai_pass)
	
	# 8. parse: Phân tích dữ liệu cấu hình từ chuỗi
	var chuoi_cau_hinh = """
	[NguoiChoi]
	ten=AnhHung
	diem=1000
	
	[CaiDat]
	am_luong=0.8
	"""
	var loi_phan_tich = config_tai.parse(chuoi_cau_hinh)
	if loi_phan_tich == OK:
		print("Phân tích chuỗi cấu hình thành công!")
	else:
		print("Lỗi khi phân tích chuỗi cấu hình: ", loi_phan_tich)
	
	# 9. get_sections: Lấy danh sách tất cả các section
	var danh_sach_section = config_tai.get_sections()
	print("Các section tìm thấy: ", danh_sach_section)
	
	# 10. get_section_keys: Lấy tất cả các khóa trong một section
	var danh_sach_khoa = config_tai.get_section_keys("NguoiChoi")
	print("Các khóa trong section NguoiChoi: ", danh_sach_khoa)
	
	# 11. has_section: Kiểm tra xem section có tồn tại không
	var co_nguoi_choi = config_tai.has_section("NguoiChoi")
	print("Có section NguoiChoi: ", co_nguoi_choi)
	
	# 12. has_section_key: Kiểm tra xem cặp section-khóa có tồn tại không
	var co_ten = config_tai.has_section_key("NguoiChoi", "ten")
	print("Có NguoiChoi.ten: ", co_ten)
	
	# 13. get_value: Lấy giá trị từ section và khóa, với giá trị mặc định nếu không tồn tại
	var ten_nguoi_choi = config_tai.get_value("NguoiChoi", "ten", "KhongTen")
	var khong_ton_tai = config_tai.get_value("NguoiChoi", "khong_ton_tai", "GiaTriMacDinh")
	print("Tên người chơi: ", ten_nguoi_choi)
	print("Khóa không tồn tại: ", khong_ton_tai)
	
	# 14. erase_section_key: Xóa một khóa cụ thể trong section
	config_tai.erase_section_key("CaiDat", "am_luong")
	var co_am_luong = config_tai.has_section_key("CaiDat", "am_luong")
	print("Có CaiDat.am_luong sau khi xóa: ", co_am_luong)
	
	# 15. erase_section: Xóa toàn bộ section
	config_tai.erase_section("KhoDo")
	var co_kho_do = config_tai.has_section("KhoDo")
	print("Có section KhoDo sau khi xóa: ", co_kho_do)
	
	# 16. clear: Xóa toàn bộ nội dung ConfigFile
	config_tai.clear()
	var section_sau_xoa = config_tai.get_sections()
	print("Các section sau khi xóa: ", section_sau_xoa)
