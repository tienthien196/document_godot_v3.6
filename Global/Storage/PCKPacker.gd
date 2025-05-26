extends Node

func _ready():
	# Tạo một đối tượng PCKPacker mới
	var packer = PCKPacker.new()
	
	# Tạo file văn bản mẫu để đóng gói
	var file = File.new()
	var loi_tao_file = file.open("user://mau_van_ban.txt", File.WRITE)
	if loi_tao_file == OK:
		file.store_string("Đây là nội dung file văn bản mẫu.")
		file.close()
		print("Tạo file mẫu 'mau_van_ban.txt' thành công!")
	else:
		print("Lỗi khi tạo file mẫu: ", loi_tao_file)
	
	# Tạo file ảnh mẫu để đóng gói (giả lập một file ảnh đơn giản)
	loi_tao_file = file.open("user://mau_anh.png", File.WRITE)
	if loi_tao_file == OK:
		file.store_string("Đây là nội dung giả lập của file ảnh.")
		file.close()
		print("Tạo file mẫu 'mau_anh.png' thành công!")
	else:
		print("Lỗi khi tạo file mẫu: ", loi_tao_file)
	
	# 1. pck_start: Bắt đầu tạo một gói PCK mới
	var loi_bat_dau = packer.pck_start("user://goi_mau.pck", 0)
	if loi_bat_dau == OK:
		print("Bắt đầu tạo gói PCK 'goi_mau.pck' thành công!")
	else:
		print("Lỗi khi bắt đầu gói PCK: ", loi_bat_dau)
	
	# 2. add_file: Thêm các file vào gói PCK
	var loi_them_file = packer.add_file("res://van_ban.txt", "user://mau_van_ban.txt")
	if loi_them_file == OK:
		print("Thêm file 'van_ban.txt' vào gói PCK thành công!")
	else:
		print("Lỗi khi thêm file 'van_ban.txt': ", loi_them_file)
	
	loi_them_file = packer.add_file("res://anh.png", "user://mau_anh.png")
	if loi_them_file == OK:
		print("Thêm file 'anh.png' vào gói PCK thành công!")
	else:
		print("Lỗi khi thêm file 'anh.png': ", loi_them_file)
	
	# 3. flush: Ghi các file đã thêm vào gói PCK
	var loi_ghi = packer.flush(true) # verbose = true để in danh sách file
	if loi_ghi == OK:
		print("Ghi các file vào gói PCK thành công!")
	else:
		print("Lỗi khi ghi gói PCK: ", loi_ghi)
	
	# Thử tải gói PCK để kiểm tra (sử dụng ProjectSettings.load_resource_pack)
	var tai_goi = ProjectSettings.load_resource_pack("user://goi_mau.pck")
	if tai_goi:
		print("Tải gói PCK thành công!")
		
		# Kiểm tra xem file trong gói có tồn tại không
		var kiem_tra_file = File.new()
		var co_file = kiem_tra_file.file_exists("res://van_ban.txt")
		print("File 'res://van_ban.txt' tồn tại trong gói: ", co_file)
		
		# Đọc nội dung file từ gói
		if co_file:
			var loi_mo = kiem_tra_file.open("res://van_ban.txt", File.READ)
			if loi_mo == OK:
				var noi_dung = kiem_tra_file.get_as_text()
				print("Nội dung file 'van_ban.txt' từ gói: ", noi_dung)
				kiem_tra_file.close()
			else:
				print("Lỗi khi mở file từ gói: ", loi_mo)
	else:
		print("Lỗi khi tải gói PCK!")
