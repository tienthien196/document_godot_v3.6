extends Node

func _ready():
	# Tạo một đối tượng Directory mới
	var thu_muc = Directory.new()
	
	# 1. open: Mở một thư mục để thao tác
	var loi_mo = thu_muc.open("user://")
	if loi_mo == OK:
		print("Mở thư mục user:// thành công!")
	else:
		print("Lỗi khi mở thư mục: ", loi_mo)
	
	# 2. make_dir: Tạo một thư mục mới
	var loi_tao_thu_muc = thu_muc.make_dir("user://data")
	if loi_tao_thu_muc == OK:
		print("Tạo thư mục 'data' thành công!")
	else:
		print("Lỗi khi tạo thư mục: ", loi_tao_thu_muc)
	
	# 3. make_dir_recursive: Tạo thư mục với các thư mục trung gian
	var loi_tao_thu_muc_de_quy = thu_muc.make_dir_recursive("user://data/level1/level2")
	if loi_tao_thu_muc_de_quy == OK:
		print("Tạo thư mục 'data/level1/level2' thành công!")
	else:
		print("Lỗi khi tạo thư mục đệ quy: ", loi_tao_thu_muc_de_quy)
	
	# 4. dir_exists: Kiểm tra xem thư mục có tồn tại không
	var co_thu_muc = thu_muc.dir_exists("user://data")
	print("Thư mục 'data' tồn tại: ", co_thu_muc)
	
	# 5. file_exists: Kiểm tra xem file có tồn tại không
	# Tạo một file mẫu để kiểm tra
	var file = File.new()
	file.open("user://data/test.txt", File.WRITE)
	file.store_string("Đây là file thử nghiệm.")
	file.close()
	
	var co_file = thu_muc.file_exists("user://data/test.txt")
	print("File 'test.txt' tồn tại: ", co_file)
	
	# 6. copy: Sao chép file từ nơi này sang nơi khác
	var loi_sao_chep = thu_muc.copy("user://data/test.txt", "user://data/test_copy.txt")
	if loi_sao_chep == OK:
		print("Sao chép file thành công!")
	else:
		print("Lỗi khi sao chép file: ", loi_sao_chep)
	
	# 7. rename: Đổi tên hoặc di chuyển file/thư mục
	var loi_doi_ten = thu_muc.rename("user://data/test_copy.txt", "user://data/test_renamed.txt")
	if loi_doi_ten == OK:
		print("Đổi tên file thành công!")
	else:
		print("Lỗi khi đổi tên file: ", loi_doi_ten)
	
	# 8. get_current_dir: Lấy đường dẫn tuyệt đối của thư mục hiện tại
	var thu_muc_hien_tai = thu_muc.get_current_dir()
	print("Thư mục hiện tại: ", thu_muc_hien_tai)
	
	# 9. get_current_drive: Lấy chỉ số ổ đĩa hiện tại
	var chi_so_o_dia = thu_muc.get_current_drive()
	print("Chỉ số ổ đĩa hiện tại: ", chi_so_o_dia)
	
	# 10. get_drive_count: Lấy số lượng ổ đĩa/volume
	var so_o_dia = thu_muc.get_drive_count()
	print("Số lượng ổ đĩa/volume: ", so_o_dia)
	
	# 11. get_drive: Lấy tên ổ đĩa/volume theo chỉ số
	for i in range(so_o_dia):
		var ten_o_dia = thu_muc.get_drive(i)
		print("Ổ đĩa/volume ", i, ": ", ten_o_dia)
	
	# 12. get_space_left: Lấy dung lượng trống (chỉ hoạt động trên hệ thống UNIX)
	var dung_luong_trong = thu_muc.get_space_left()
	print("Dung lượng trống (byte): ", dung_luong_trong)
	
	# 13. list_dir_begin và get_next: Liệt kê nội dung thư mục
	var loi_liet_ke = thu_muc.list_dir_begin(true, true) # Bỏ qua . và .., bỏ qua file ẩn
	if loi_liet_ke == OK:
		print("Danh sách nội dung thư mục user://:")
		var ten = thu_muc.get_next()
		while ten != "":
			if thu_muc.current_is_dir():
				print("Thư mục: ", ten)
			else:
				print("File: ", ten)
			ten = thu_muc.get_next()
	else:
		print("Lỗi khi liệt kê thư mục: ", loi_liet_ke)
	
	# 14. current_is_dir: Kiểm tra xem mục hiện tại có phải là thư mục không
	# (Đã được sử dụng trong vòng lặp trên)
	
	# 15. list_dir_end: Đóng luồng liệt kê thư mục
	thu_muc.list_dir_end()
	print("Đã đóng luồng liệt kê thư mục.")
	
	# 16. remove: Xóa file hoặc thư mục rỗng
	var loi_xoa = thu_muc.remove("user://data/test_renamed.txt")
	if loi_xoa == OK:
		print("Xóa file 'test_renamed.txt' thành công!")
	else:
		print("Lỗi khi xóa file: ", loi_xoa)