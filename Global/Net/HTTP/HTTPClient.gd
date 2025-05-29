extends Node

func _ready():
	# Tạo một đối tượng HTTPClient mới để thực hiện các yêu cầu HTTP
	# HTTPClient là một lớp trong Godot dùng để gửi và nhận dữ liệu qua giao thức HTTP/HTTPS
	var client = HTTPClient.new()
	
	# 1. Thiết lập chế độ chặn (blocking mode)
	# Chế độ chặn làm cho các hàm của HTTPClient chờ cho đến khi hoàn thành thao tác thay vì chạy không đồng bộ
	client.set_blocking_mode(true)
	# Kiểm tra xem chế độ chặn đã được bật hay chưa
	if client.is_blocking_mode_enabled():
		print("Chế độ chặn được bật: Các yêu cầu HTTP sẽ chờ hoàn thành trước khi tiếp tục.")
	else:
		print("Chế độ chặn không được bật: Có thể gây lỗi nếu không xử lý đúng luồng.")
	
	# 2. Thiết lập kích thước chunk đọc
	# read_chunk_size quyết định số byte tối đa được đọc mỗi lần khi nhận dữ liệu từ server
	# Ở đây, thiết lập thành 4096 bytes (4KB) để tối ưu hóa việc đọc dữ liệu
	client.set_read_chunk_size(4096)
	if client.get_read_chunk_size() == 4096:
		print("Kích thước chunk đọc được thiết lập thành 4096 bytes: Dữ liệu sẽ được đọc theo khối 4KB.")
	else:
		print("Lỗi khi thiết lập kích thước chunk đọc: Kích thước không đúng như mong đợi.")
	
	# 3. Thiết lập proxy cho kết nối HTTP và HTTPS
	# Proxy là máy chủ trung gian giúp chuyển tiếp yêu cầu HTTP/HTTPS
	# Ở đây, sử dụng một proxy giả lập (proxy.example.com) với cổng 8080 cho HTTP và 8443 cho HTTPS
	client.set_http_proxy("proxy.example.com", 8080)
	client.set_https_proxy("proxy.example.com", 8443)
	print("Đã thiết lập proxy HTTP và HTTPS: Các yêu cầu sẽ đi qua proxy server.")
	
	# 4. Kết nối tới host (httpbin.org)
	# connect_to_host thiết lập kết nối tới server, ở đây là httpbin.org
	# Tham số: -1 (cổng mặc định), true (sử dụng SSL cho HTTPS), true (xác minh SSL)
	var err = client.connect_to_host("httpbin.org", -1, true, true)
	if err == OK:
		print("Kết nối tới httpbin.org thành công: Sẵn sàng gửi yêu cầu HTTP.")
	else:
		print("Lỗi khi kết nối tới host: ", err, " - Kiểm tra kết nối mạng hoặc URL.")
		return # Thoát hàm nếu kết nối thất bại
	

	# ===================================CONNECTING==============================================
	# 5. Chờ trạng thái kết nối
	# Vòng lặp này kiểm tra xem client đang phân giải tên miền (DNS) hoặc đang kết nối
	while client.get_status() == HTTPClient.STATUS_RESOLVING or client.get_status() == HTTPClient.STATUS_CONNECTING:
		client.poll() # Cập nhật trạng thái của client
		OS.delay_msec(100) # Chờ 100ms để tránh chiếm quá nhiều tài nguyên CPU
	
	# Kiểm tra trạng thái sau khi kết nối
	# Nếu trạng thái là STATUS_CONNECTED, kết nối đã thành công
	if client.get_status() == HTTPClient.STATUS_CONNECTED:
		print("Trạng thái: Kết nối thành công - Có thể bắt đầu gửi yêu cầu.")
	else:
		print("Trạng thái: Lỗi kết nối - ", get_status_name(client.get_status()), ": Kiểm tra lỗi cụ thể.")
		return # Thoát hàm nếu không kết nối được
	
	# 6. Lấy đối tượng StreamPeer connection
	# StreamPeer là một lớp thấp hơn trong Godot, quản lý kết nối mạng thực tế
	var connection = client.get_connection()
	if connection:
		print("Lấy được StreamPeer connection: Kết nối mạng đã sẵn sàng.")
	else:
		print("Không lấy được StreamPeer connection: Lỗi trong quá trình thiết lập kết nối.")
	

	# ==========================================REQUESTING=============================================================
	# 7. Gửi yêu cầu GET tới endpoint "/get"
	# Yêu cầu GET lấy thông tin từ server, ở đây gửi tới httpbin.org/get
	# headers là danh sách các tiêu đề HTTP, ví dụ: User-Agent để định danh client
	var headers = ["User-Agent: Godot/HTTPClient"]
	err = client.request(HTTPClient.METHOD_GET, "/get", headers)
	if err == OK:
		print("Gửi yêu cầu GET thành công: Chờ phản hồi từ server.")
	else:
		print("Lỗi khi gửi yêu cầu GET: ", err, " - Kiểm tra URL hoặc headers.")
		return # Thoát hàm nếu gửi yêu cầu thất bại
	
	# 8. Chờ xử lý phản hồi từ server
	# Khi trạng thái là STATUS_REQUESTING, client đang gửi yêu cầu và chờ phản hồi
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll() # Cập nhật trạng thái
		OS.delay_msec(100) # Chờ 100ms để tránh chiếm CPU
	
	# Kiểm tra trạng thái sau khi gửi yêu cầu
	if client.get_status() == HTTPClient.STATUS_BODY:
		print("Trạng thái: Nhận được body phản hồi - Bắt đầu đọc dữ liệu.")
	elif client.get_status() == HTTPClient.STATUS_CONNECTION_ERROR:
		print("Trạng thái: Lỗi kết nối - Không thể nhận dữ liệu từ server.")
		return # Thoát hàm nếu có lỗi kết nối
	
	# 9. Kiểm tra xem server có trả về phản hồi không
	if client.has_response():
		print("Có phản hồi từ server: Server đã gửi dữ liệu về.")
	else:
		print("Không có phản hồi từ server: Có thể server không trả về dữ liệu.")
	
	# 10. Kiểm tra xem phản hồi có sử dụng chunked transfer encoding không
	# Chunked encoding là cách server gửi dữ liệu theo từng mảnh nhỏ
	if client.is_response_chunked():
		print("Phản hồi sử dụng chunked transfer encoding: Dữ liệu được gửi theo từng khối.")
	else:
		print("Phản hồi không sử dụng chunked transfer encoding: Dữ liệu gửi một lần duy nhất.")
	
	# 11. Lấy mã phản hồi HTTP (ví dụ: 200 OK, 404 Not Found)
	var response_code = client.get_response_code()
	print("Mã phản hồi HTTP: ", response_code, " (200 là thành công, 404 là không tìm thấy, v.v.)")
	
	# 12. Lấy danh sách header phản hồi
	# Header chứa thông tin bổ sung như loại nội dung, độ dài, v.v.
	var response_headers = client.get_response_headers()
	print("Header phản hồi: ", response_headers, " - Chứa thông tin về phản hồi.")
	
	# 13. Lấy header dưới dạng dictionary để dễ xử lý
	var headers_dict = client.get_response_headers_as_dictionary()
	print("Header phản hồi (dictionary): ", headers_dict, " - Định dạng dễ sử dụng hơn.")
	
	# 14. Lấy độ dài body phản hồi
	# Độ dài body cho biết số byte dữ liệu server gửi về
	var body_length = client.get_response_body_length()
	if body_length >= 0:
		print("Độ dài body phản hồi: ", body_length, " bytes - Biết trước kích thước dữ liệu.")
	else:
		print("Không xác định được độ dài body phản hồi: Có thể là chunked encoding.")
	
	# 15. Đọc body phản hồi theo từng chunk
	# Dữ liệu được đọc theo các khối (chunk) dựa trên read_chunk_size đã thiết lập
	var response_body = PoolByteArray() # Mảng byte để lưu dữ liệu phản hồi
	while client.get_status() == HTTPClient.STATUS_BODY:
		var chunk = client.read_response_body_chunk() # Đọc một khối dữ liệu
		if chunk.size() > 0:
			response_body.append_array(chunk) # Thêm khối vào mảng
			print("Đọc được chunk: ", chunk.size(), " bytes - Tổng dữ liệu đang tăng.")
		client.poll() # Cập nhật trạng thái
		OS.delay_msec(100) # Chờ 100ms
	
	# Chuyển mảng byte thành chuỗi UTF-8 để đọc nội dung
	var body_string = response_body.get_string_from_utf8()
	print("Nội dung phản hồi GET: ", body_string, " - Dữ liệu server gửi về.")
	
	# 16. Gửi yêu cầu POST với dữ liệu dạng query string
	# Query string là định dạng key=value, ví dụ: username=test_user&data=value1
	var fields = {"username": "test_user", "data": ["value1", "value2"]}
	var query_string = client.query_string_from_dict(fields) # Tạo query string từ dictionary
	var post_headers = [
		"Content-Type: application/x-www-form-urlencoded", # Loại nội dung là form
		"Content-Length: " + str(query_string.length()) # Độ dài dữ liệu gửi đi
	]
	err = client.request(HTTPClient.METHOD_POST, "/post", post_headers, query_string)
	if err == OK:
		print("Gửi yêu cầu POST thành công: Dữ liệu form đã được gửi.")
	else:
		print("Lỗi khi gửi yêu cầu POST: ", err, " - Kiểm tra headers hoặc query string.")
		return # Thoát hàm nếu gửi thất bại
	
	# 17. Xử lý phản hồi từ yêu cầu POST
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll() # Cập nhật trạng thái
		OS.delay_msec(100) # Chờ 100ms
	
	if client.get_status() == HTTPClient.STATUS_BODY:
		response_body = PoolByteArray() # Khởi tạo lại mảng byte
		while client.get_status() == HTTPClient.STATUS_BODY:
			var chunk = client.read_response_body_chunk() # Đọc từng khối
			if chunk.size() > 0:
				response_body.append_array(chunk) # Thêm vào mảng
			client.poll() # Cập nhật trạng thái
			OS.delay_msec(100) # Chờ 100ms
		body_string = response_body.get_string_from_utf8() # Chuyển thành chuỗi
		print("Nội dung phản hồi POST: ", body_string, " - Dữ liệu server trả về.")
	else:
		print("Trạng thái sau POST: ", get_status_name(client.get_status()), " - Kiểm tra lỗi.")
	
	# 18. Gửi yêu cầu POST với dữ liệu thô (raw)
	# Dữ liệu thô là dữ liệu không định dạng, ví dụ: một chuỗi byte tùy chỉnh
	var raw_body = "Raw data for POST".to_utf8() # Chuyển chuỗi thành mảng byte
	var raw_headers = ["Content-Length: " + str(raw_body.size())] # Độ dài dữ liệu
	err = client.request_raw(HTTPClient.METHOD_POST, "/post", raw_headers, raw_body)
	if err == OK:
		print("Gửi yêu cầu POST raw thành công: Dữ liệu thô đã được gửi.")
	else:
		print("Lỗi khi gửi yêu cầu POST raw: ", err, " - Kiểm tra dữ liệu hoặc headers.")
		return # Thoát hàm nếu gửi thất bại
	
	# 19. Xử lý phản hồi từ yêu cầu POST raw
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll() # Cập nhật trạng thái
		OS.delay_msec(100) # Chờ 100ms
	
	if client.get_status() == HTTPClient.STATUS_BODY:
		response_body = PoolByteArray() # Khởi tạo lại mảng byte
		while client.get_status() == HTTPClient.STATUS_BODY:
			var chunk = client.read_response_body_chunk() # Đọc từng khối
			if chunk.size() > 0:
				response_body.append_array(chunk) # Thêm vào mảng
			client.poll() # Cập nhật trạng thái
			OS.delay_msec(100) # Chờ 100ms
		body_string = response_body.get_string_from_utf8() # Chuyển thành chuỗi
		print("Nội dung phản hồi POST raw: ", body_string, " - Dữ liệu server trả về.")
	else:
		print("Trạng thái sau POST raw: ", get_status_name(client.get_status()), " - Kiểm tra lỗi.")
	
	# 20. Đóng kết nối
	# Đóng kết nối để giải phóng tài nguyên mạng
	client.close()
	if client.get_status() == HTTPClient.STATUS_DISCONNECTED:
		print("Kết nối đã được đóng thành công: Tài nguyên đã được giải phóng.")
	else:
		print("Lỗi khi đóng kết nối: ", get_status_name(client.get_status()), " - Kiểm tra trạng thái.")

# Hàm hỗ trợ để lấy tên trạng thái của HTTPClient
# Chuyển đổi mã trạng thái (số) thành tên trạng thái (chuỗi) để dễ đọc
func get_status_name(status):
	match status:
		HTTPClient.STATUS_DISCONNECTED:
			return "DISCONNECTED" # Không có kết nối
		HTTPClient.STATUS_RESOLVING:
			return "RESOLVING" # Đang phân giải tên miền
		HTTPClient.STATUS_CANT_RESOLVE:
			return "CANT_RESOLVE" # Không thể phân giải tên miền
		HTTPClient.STATUS_CONNECTING:
			return "CONNECTING" # Đang kết nối
		HTTPClient.STATUS_CANT_CONNECT:
			return "CANT_CONNECT" # Không thể kết nối
		HTTPClient.STATUS_CONNECTED:
			return "CONNECTED" # Đã kết nối
		HTTPClient.STATUS_REQUESTING:
			return "REQUESTING" # Đang gửi yêu cầu
		HTTPClient.STATUS_BODY:
			return "BODY" # Đang nhận body phản hồi
		HTTPClient.STATUS_CONNECTION_ERROR:
			return "CONNECTION_ERROR" # Lỗi kết nối
		HTTPClient.STATUS_SSL_HANDSHAKE_ERROR:
			return "SSL_HANDSHAKE_ERROR" # Lỗi bắt tay SSL
		_:
			return "UNKNOWN" # Trạng thái không xác định