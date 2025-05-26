extends Node

# Biến dùng chung được bảo vệ bởi Mutex
var bien_chung = 0
var mutex = Mutex.new()
var threads = []

# Hàm mẫu chạy trong thread để tăng giá trị bien_chung
func tang_bien_chung(userdata):
	# Mô phỏng công việc nặng
	for i in range(100000):
		# 1. lock: Khóa Mutex để truy cập biến chung
		mutex.lock()
		
		# Tăng giá trị biến chung
		bien_chung += 1
		var gia_tri = bien_chung
		# In thông tin để debug
		print("Thread ", Thread.new().get_id(), " tăng bien_chung lên: ", gia_tri)
		
		# 2. unlock: Mở khóa Mutex sau khi xong
		mutex.unlock()
	
	# Trả về kết quả (không sử dụng trong ví dụ này)
	return userdata

# Hàm thử sử dụng try_lock
func thu_try_lock(userdata):
	# Thử khóa Mutex mà không chặn luồng
	var ket_qua = mutex.try_lock()
	if ket_qua == OK:
		# 3. try_lock: Khóa thành công
		print("Thread ", Thread.new().get_id(), " khóa thành công với try_lock!")
		bien_chung += 1
		var gia_tri = bien_chung
		print("Thread ", Thread.new().get_id(), " tăng bien_chung lên: ", gia_tri)
		# Mở khóa sau khi xong
		mutex.unlock()
	else:
		# Không khóa được (bận)
		print("Thread ", Thread.new().get_id(), " không khóa được với try_lock (ERR_BUSY).")
	
	# Trả về kết quả
	return userdata

func _ready():
	# Khởi tạo Mutex
	mutex = Mutex.new()
	
	# Tạo và khởi động 3 thread sử dụng lock/unlock
	for i in range(3):
		var thread = Thread.new()
		threads.append(thread)
		var loi_khoi_dong = thread.start(self, "tang_bien_chung", "Thread " + str(i))
		if loi_khoi_dong == OK:
			print("Khởi động thread ", i, " thành công!")
		else:
			print("Lỗi khi khởi động thread ", i, ": ", loi_khoi_dong)
	
	# Đợi tất cả thread hoàn thành
	for thread in threads:
		if thread.is_active():
			var ket_qua = thread.wait_to_finish()
			print("Thread hoàn thành với userdata: ", ket_qua)
	
	# In giá trị cuối cùng của bien_chung
	print("Giá trị cuối cùng của bien_chung sau lock/unlock: ", bien_chung)
	
	# Đặt lại bien_chung và threads để thử với try_lock
	bien_chung = 0
	threads.clear()
	
	# Tạo và khởi động 3 thread sử dụng try_lock
	for i in range(3):
		var thread = Thread.new()
		threads.append(thread)
		var loi_khoi_dong = thread.start(self, "thu_try_lock", "Thread Try " + str(i))
		if loi_khoi_dong == OK:
			print("Khởi động thread try_lock ", i, " thành công!")
		else:
			print("Lỗi khi khởi động thread try_lock ", i, ": ", loi_khoi_dong)
	
	# Đợi tất cả thread hoàn thành
	for thread in threads:
		if thread.is_active():
			var ket_qua = thread.wait_to_finish()
			print("Thread try_lock hoàn thành với userdata: ", ket_qua)
	
	# In giá trị cuối cùng của bien_chung
	print("Giá trị cuối cùng của bien_chung sau try_lock: ", bien_chung)

func _exit_tree():
	# Đảm bảo tất cả thread được giải phóng an toàn
	for thread in threads:
		if thread and thread.is_active():
			thread.wait_to_finish()
			print("Thread đã được giải phóng an toàn khi thoát.")
	
	# Đảm bảo Mutex không bị khóa khi thoát
	# (Trong ví dụ này, Mutex đã được mở khóa đúng cách trong các thread)
