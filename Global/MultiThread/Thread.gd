extends Node

# Biến để lưu thread
var thread = null

# Hàm mẫu để chạy trong thread
func ham_mau(userdata):
	# Mô phỏng một tác vụ nặng
	var ket_qua = 0
	for i in range(1000000):
		ket_qua += i
	# In thông tin thread từ bên trong thread
	print("Đang chạy trong thread ID: ", Thread.new().get_id())
	# Trả về kết quả với userdata
	return {"ket_qua": ket_qua, "userdata": userdata}

func _ready():
	# Tạo một đối tượng Thread mới
	thread = Thread.new()
	
	# 1. get_id: Lấy ID của thread (trước khi khởi động)
	var id_truoc = thread.get_id()
	print("ID của thread trước khi khởi động: ", id_truoc) # Sẽ là chuỗi rỗng
	
	# 2. is_active: Kiểm tra xem thread có đang ở trạng thái active không
	var dang_active_truoc = thread.is_active()
	print("Thread đang active trước khi khởi động: ", dang_active_truoc) # False
	
	# 3. is_alive: Kiểm tra xem thread có đang chạy không
	var dang_chay_truoc = thread.is_alive()
	print("Thread đang chạy trước khi khởi động: ", dang_chay_truoc) # False
	
	# 4. start: Khởi động thread với hàm mẫu và userdata
	var du_lieu = "Dữ liệu thử nghiệm"
	var loi_khoi_dong = thread.start(self, "ham_mau", du_lieu, Thread.PRIORITY_HIGH)
	if loi_khoi_dong == OK:
		print("Khởi động thread thành công với ưu tiên cao!")
	else:
		print("Lỗi khi khởi động thread: ", loi_khoi_dong)
	
	# 5. get_id: Lấy ID của thread sau khi khởi động
	var id_sau = thread.get_id()
	print("ID của thread sau khi khởi động: ", id_sau) # Sẽ trả về một ID duy nhất
	
	# 6. is_active: Kiểm tra lại trạng thái active
	var dang_active_sau = thread.is_active()
	print("Thread đang active sau khi khởi động: ", dang_active_sau) # True
	
	# 7. is_alive: Kiểm tra xem thread có đang chạy không
	var dang_chay_sau = thread.is_alive()
	print("Thread đang chạy sau khi khởi động: ", dang_chay_sau) # True
	
	# 8. wait_to_finish: Đợi thread hoàn thành và lấy kết quả
	var ket_qua = thread.wait_to_finish()
	print("Kết quả từ thread: ", ket_qua)
	
	# Kiểm tra trạng thái sau khi thread hoàn thành
	var dang_active_sau_hoan_thanh = thread.is_active()
	print("Thread đang active sau khi hoàn thành: ", dang_active_sau_hoan_thanh) # False
	
	var dang_chay_sau_hoan_thanh = thread.is_alive()
	print("Thread đang chạy sau khi hoàn thành: ", dang_chay_sau_hoan_thanh) # False
	
	# Thử khởi động lại thread (sẽ thất bại vì thread đã được giải phóng)
	var loi_khoi_dong_lai = thread.start(self, "ham_mau", null)
	if loi_khoi_dong_lai != OK:
		print("Không thể khởi động lại thread đã hoàn thành!")
	
	# Tạo thread mới để sử dụng lại
	thread = Thread.new()
	var loi_khoi_dong_moi = thread.start(self, "ham_mau", "Thread mới", Thread.PRIORITY_LOW)
	if loi_khoi_dong_moi == OK:
		print("Khởi động thread mới với ưu tiên thấp thành công!")
	else:
		print("Lỗi khi khởi động thread mới: ", loi_khoi_dong_moi)
	
	# Đợi thread mới hoàn thành
	var ket_qua_moi = thread.wait_to_finish()
	print("Kết quả từ thread mới: ", ket_qua_moi)

func _exit_tree():
	# Đảm bảo thread được giải phóng an toàn khi thoát
	if thread and thread.is_active():
		thread.wait_to_finish()
		print("Thread đã được giải phóng an toàn khi thoát.")



# extends Node

# # Initialize threads and mutex for thread-safe printing
# var threads = []
# var print_mutex = Mutex.new()

# func _ready():
# 	# Step 1: Create threads with different priorities
# 	var priorities = [
# 		[Thread.PRIORITY_LOW, "Low"],
# 		[Thread.PRIORITY_NORMAL, "Normal"],
# 		[Thread.PRIORITY_HIGH, "High"]
# 	]
	
# 	for priority_info in priorities:
# 		var priority = priority_info[0]
# 		var priority_name = priority_info[1]
		
# 		# Create a new thread
# 		var thread = Thread.new()
# 		threads.append(thread)
		
# 		# Step 2: Start the thread
# 		var err = thread.start(self, "_thread_function", [priority_name, 40], priority)
# 		if err == OK:
# 			thread_safe_print("Started thread with %s priority. Thread ID: %s" % [priority_name, thread.get_id()])
# 		else:
# 			thread_safe_print("Failed to start thread with %s priority: %s" % [priority_name, err])
# 			continue
		
# 		# Step 3: Check thread status
# 		thread_safe_print("Thread ID %s is_active: %s" % [thread.get_id(), thread.is_active()])
# 		thread_safe_print("Thread ID %s is_alive: %s" % [thread.get_id(), thread.is_alive()])
	
# 	# Step 4: Wait for all threads to finish and retrieve results
# 	for thread in threads:
# 		if thread.is_active():
# 			var thread_id = thread.get_id()
# 			var result = thread.wait_to_finish()
# 			thread_safe_print("Thread ID %s finished with result: %s" % [thread_id, result])
			
# 			# Step 5: Verify thread is no longer active or alive
# 			thread_safe_print("Thread ID %s is_active after finish: %s" % [thread_id, thread.is_active()])
# 			thread_safe_print("Thread ID %s is_alive after finish: %s" % [thread_id, thread.is_alive()])
	
# 	# Step 6: Demonstrate invalid thread start (error case)
# 	var invalid_thread = Thread.new()
# 	var err = invalid_thread.start(self, "non_existent_method")
# 	if err != OK:
# 		thread_safe_print("Expected failure when starting thread with invalid method: %s" % err)
	
# 	# Step 7: Demonstrate get_id on non-started thread
# 	var non_started_thread = Thread.new()
# 	thread_safe_print("Non-started thread ID: %s (should be empty)" % non_started_thread.get_id())

# # Thread function to compute Fibonacci number
# func _thread_function(userdata):
# 	var priority_name = userdata[0]
# 	var n = userdata[1]
	
# 	# Simulate a computationally intensive task
# 	var result = fibonacci(n)
	
# 	# Thread-safe print to indicate thread is running
# 	thread_safe_print("Thread with %s priority computing Fibonacci(%d)" % [priority_name, n])
	
# 	# Return the result
# 	return result

# # Helper function to compute Fibonacci number
# func fibonacci(n: int) -> int:
# 	if n <= 1:
# 		return n
# 	var a = 0
# 	var b = 1
# 	for i in range(2, n + 1):
# 		var temp = a + b
# 		a = b
# 		b = temp
# 	return b

# # Helper function for thread-safe printing
# func thread_safe_print(message: String):
# 	print_mutex.lock()
# 	print(message)
# 	print_mutex.unlock()

# func _exit_tree():
# 	# Ensure all threads are finished before exiting to prevent crashes
# 	for thread in threads:
# 		if thread.is_active() and thread.is_alive():
# 			thread.wait_to_finish()
