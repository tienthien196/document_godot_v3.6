extends Node

# Biến dùng chung để đếm số lượng công việc hoàn thành
var cong_viec_hoan_thanh = 0
var semaphore = Semaphore.new()
var threads = []
const SO_LUONG_CONG_VIEC = 5

# Hàm mẫu chạy trong thread để mô phỏng công việc
func cong_viec_mau(userdata):
	# Mô phỏng công việc nặng
	for i in range(100000):
		pass
	
	# 1. wait: Chờ Semaphore để truy cập tài nguyên
	var loi_cho = semaphore.wait()
	if loi_cho == OK:
		print("Thread ", Thread.new().get_id(), " đã vượt qua Semaphore (wait).")
	else:
		print("Lỗi khi chờ Semaphore: ", loi_cho)
	
	# Tăng biến chung
	cong_viec_hoan_thanh += 1
	var gia_tri = cong_viec_hoan_thanh
	print("Thread ", Thread.new().get_id(), " tăng công việc hoàn thành lên: ", gia_tri)
	
	# 2. post: Tăng Semaphore để cho phép thread khác tiếp tục
	var loi_tang = semaphore.post()
	if loi_tang == OK:
		print("Thread ", Thread.new().get_id(), " đã gọi post thành công.")
	else:
		print("Lỗi khi gọi post: ", loi_tang)
	
	# Trả về kết quả
	return userdata

# Hàm thử sử dụng try_wait
func thu_try_wait(userdata):
	# 3. try_wait: Thử chờ Semaphore mà không chặn
	var loi_thu = semaphore.try_wait()
	if loi_thu == OK:
		print("Thread ", Thread.new().get_id(), " vượt qua Semaphore với try_wait!")
		cong_viec_hoan_thanh += 1
		var gia_tri = cong_viec_hoan_thanh
		print("Thread ", Thread.new().get_id(), " tăng công việc hoàn thành lên: ", gia_tri)
		
		# Gọi post để tăng Semaphore
		semaphore.post()
	else:
		print("Thread ", Thread.new().get_id(), " không vượt qua được try_wait (ERR_BUSY).")
	
	# Trả về kết quả
	return userdata

func _ready():
	# Khởi tạo Semaphore
	semaphore = Semaphore.new()
	
	# Gọi post ban đầu để cho phép một số thread vượt qua
	for i in range(2): # Cho phép 2 thread chạy đồng thời
		semaphore.post()
	
	# Tạo và khởi động các thread sử dụng wait/post
	for i in range(SO_LUONG_CONG_VIEC):
		var thread = Thread.new()
		threads.append(thread)
		var loi_khoi_dong = thread.start(self, "cong_viec_mau", "Thread " + str(i))
		if loi_khoi_dong == OK:
			print("Khởi động thread ", i, " thành công!")
		else:
			print("Lỗi khi khởi động thread ", i, ": ", loi_khoi_dong)
	
	# Đợi tất cả thread hoàn thành
	for thread in threads:
		if thread.is_active():
			var ket_qua = thread.wait_to_finish()
			print("Thread hoàn thành với userdata: ", ket_qua)
	
	# In giá trị cuối cùng của cong_viec_hoan_thanh
	print("Số công việc hoàn thành sau wait/post: ", cong_viec_hoan_thanh)
	
	# Đặt lại biến và threads để thử với try_wait
	cong_viec_hoan_thanh = 0
	threads.clear()
	
	# Gọi post để cho phép một số thread vượt qua
	for i in range(2): # Cho phép 2 thread chạy đồng thời
		semaphore.post()
	
	# Tạo và khởi động các thread sử dụng try_wait
	for i in range(SO_LUONG_CONG_VIEC):
		var thread = Thread.new()
		threads.append(thread)
		var loi_khoi_dong = thread.start(self, "thu_try_wait", "Thread Try " + str(i))
		if loi_khoi_dong == OK:
			print("Khởi động thread try_wait ", i, " thành công!")
		else:
			print("Lỗi khi khởi động thread try_wait ", i, ": ", loi_khoi_dong)
	
	# Đợi tất cả thread hoàn thành
	for thread in threads:
		if thread.is_active():
			var ket_qua = thread.wait_to_finish()
			print("Thread try_wait hoàn thành với userdata: ", ket_qua)
	
	# In giá trị cuối cùng của cong_viec_hoan_thanh
	print("Số công việc hoàn thành sau try_wait: ", cong_viec_hoan_thanh)

func _exit_tree():
	# Đảm bảo tất cả thread được giải phóng an toàn
	for thread in threads:
		if thread and thread.is_active():
			thread.wait_to_finish()
			print("Thread đã được giải phóng an toàn khi thoát.")
	
	# Đảm bảo không có thread nào đang chờ Semaphore khi thoát
	# (Trong ví dụ này, tất cả thread đã hoàn thành và gọi post đúng cách)
