extends Node

func _ready():
	# Tạo một đối tượng HTTPClient mới
	var client = HTTPClient.new()
	
	# 1. Thiết lập thuộc tính blocking_mode_enabled
	client.set_blocking_mode(true)
	if client.is_blocking_mode_enabled():
		print("Chế độ chặn được bật.")
	else:
		print("Chế độ chặn không được bật.")
	
	# 2. Thiết lập read_chunk_size
	client.set_read_chunk_size(4096)
	if client.get_read_chunk_size() == 4096:
		print("Kích thước chunk đọc được thiết lập thành 4096 bytes.")
	else:
		print("Lỗi khi thiết lập kích thước chunk đọc.")
	
	# 3. Thiết lập proxy (ví dụ, giả lập proxy server)
	client.set_http_proxy("proxy.example.com", 8080)
	client.set_https_proxy("proxy.example.com", 8443)
	print("Đã thiết lập proxy HTTP và HTTPS.")
	
	# 4. Kết nối tới host
	var err = client.connect_to_host("httpbin.org", -1, true, true)
	if err == OK:
		print("Kết nối tới httpbin.org thành công.")
	else:
		print("Lỗi khi kết nối tới host: ", err)
		return
	
	# 5. Chờ trạng thái kết nối
	while client.get_status() == HTTPClient.STATUS_RESOLVING or client.get_status() == HTTPClient.STATUS_CONNECTING:
		client.poll()
		OS.delay_msec(100)
	
	# Kiểm tra trạng thái kết nối
	if client.get_status() == HTTPClient.STATUS_CONNECTED:
		print("Trạng thái: Kết nối thành công.")
	else:
		print("Trạng thái: Lỗi kết nối - ", get_status_name(client.get_status()))
		return
	
	# 6. Lấy StreamPeer connection
	var connection = client.get_connection()
	if connection:
		print("Lấy được StreamPeer connection.")
	else:
		print("Không lấy được StreamPeer connection.")
	
	# 7. Gửi yêu cầu GET
	var headers = ["User-Agent: Godot/HTTPClient"]
	err = client.request(HTTPClient.METHOD_GET, "/get", headers)
	if err == OK:
		print("Gửi yêu cầu GET thành công.")
	else:
		print("Lỗi khi gửi yêu cầu GET: ", err)
		return
	
	# 8. Xử lý phản hồi
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll()
		OS.delay_msec(100)
	
	# Kiểm tra trạng thái phản hồi
	if client.get_status() == HTTPClient.STATUS_BODY:
		print("Trạng thái: Nhận được body phản hồi.")
	elif client.get_status() == HTTPClient.STATUS_CONNECTION_ERROR:
		print("Trạng thái: Lỗi kết nối.")
		return
	
	# 9. Kiểm tra xem có phản hồi không
	if client.has_response():
		print("Có phản hồi từ server.")
	else:
		print("Không có phản hồi từ server.")
	
	# 10. Kiểm tra phản hồi chunked
	if client.is_response_chunked():
		print("Phản hồi sử dụng chunked transfer encoding.")
	else:
		print("Phản hồi không sử dụng chunked transfer encoding.")
	
	# 11. Lấy mã phản hồi
	var response_code = client.get_response_code()
	print("Mã phản hồi HTTP: ", response_code)
	
	# 12. Lấy header phản hồi
	var response_headers = client.get_response_headers()
	print("Header phản hồi: ", response_headers)
	
	# 13. Lấy header dưới dạng dictionary
	var headers_dict = client.get_response_headers_as_dictionary()
	print("Header phản hồi (dictionary): ", headers_dict)
	
	# 14. Lấy độ dài body phản hồi
	var body_length = client.get_response_body_length()
	if body_length >= 0:
		print("Độ dài body phản hồi: ", body_length, " bytes")
	else:
		print("Không xác định được độ dài body phản hồi.")
	
	# 15. Đọc body phản hồi theo chunk
	var response_body = PoolByteArray()
	while client.get_status() == HTTPClient.STATUS_BODY:
		var chunk = client.read_response_body_chunk()
		if chunk.size() > 0:
			response_body.append_array(chunk)
			print("Đọc được chunk: ", chunk.size(), " bytes")
		client.poll()
		OS.delay_msec(100)
	
	# In nội dung phản hồi
	var body_string = response_body.get_string_from_utf8()
	print("Nội dung phản hồi GET: ", body_string)
	
	# 16. Gửi yêu cầu POST với query string
	var fields = {"username": "test_user", "data": ["value1", "value2"]}
	var query_string = client.query_string_from_dict(fields)
	var post_headers = [
		"Content-Type: application/x-www-form-urlencoded",
		"Content-Length: " + str(query_string.length())
	]
	err = client.request(HTTPClient.METHOD_POST, "/post", post_headers, query_string)
	if err == OK:
		print("Gửi yêu cầu POST thành công.")
	else:
		print("Lỗi khi gửi yêu cầu POST: ", err)
		return
	
	# 17. Xử lý phản hồi POST
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll()
		OS.delay_msec(100)
	
	if client.get_status() == HTTPClient.STATUS_BODY:
		response_body = PoolByteArray()
		while client.get_status() == HTTPClient.STATUS_BODY:
			var chunk = client.read_response_body_chunk()
			if chunk.size() > 0:
				response_body.append_array(chunk)
			client.poll()
			OS.delay_msec(100)
		body_string = response_body.get_string_from_utf8()
		print("Nội dung phản hồi POST: ", body_string)
	else:
		print("Trạng thái sau POST: ", get_status_name(client.get_status()))
	
	# 18. Gửi yêu cầu POST với dữ liệu thô (raw)
	var raw_body = "Raw data for POST".to_utf8()
	var raw_headers = ["Content-Length: " + str(raw_body.size())]
	err = client.request_raw(HTTPClient.METHOD_POST, "/post", raw_headers, raw_body)
	if err == OK:
		print("Gửi yêu cầu POST raw thành công.")
	else:
		print("Lỗi khi gửi yêu cầu POST raw: ", err)
		return
	
	# 19. Xử lý phản hồi POST raw
	while client.get_status() == HTTPClient.STATUS_REQUESTING:
		client.poll()
		OS.delay_msec(100)
	
	if client.get_status() == HTTPClient.STATUS_BODY:
		response_body = PoolByteArray()
		while client.get_status() == HTTPClient.STATUS_BODY:
			var chunk = client.read_response_body_chunk()
			if chunk.size() > 0:
				response_body.append_array(chunk)
			client.poll()
			OS.delay_msec(100)
		body_string = response_body.get_string_from_utf8()
		print("Nội dung phản hồi POST raw: ", body_string)
	else:
		print("Trạng thái sau POST raw: ", get_status_name(client.get_status()))
	
	# 20. Đóng kết nối
	client.close()
	if client.get_status() == HTTPClient.STATUS_DISCONNECTED:
		print("Kết nối đã được đóng thành công.")
	else:
		print("Lỗi khi đóng kết nối: ", get_status_name(client.get_status()))

# Hàm hỗ trợ để lấy tên trạng thái
func get_status_name(status):
	match status:
		HTTPClient.STATUS_DISCONNECTED:
			return "DISCONNECTED"
		HTTPClient.STATUS_RESOLVING:
			return "RESOLVING"
		HTTPClient.STATUS_CANT_RESOLVE:
			return "CANT_RESOLVE"
		HTTPClient.STATUS_CONNECTING:
			return "CONNECTING"
		HTTPClient.STATUS_CANT_CONNECT:
			return "CANT_CONNECT"
		HTTPClient.STATUS_CONNECTED:
			return "CONNECTED"
		HTTPClient.STATUS_REQUESTING:
			return "REQUESTING"
		HTTPClient.STATUS_BODY:
			return "BODY"
		HTTPClient.STATUS_CONNECTION_ERROR:
			return "CONNECTION_ERROR"
		HTTPClient.STATUS_SSL_HANDSHAKE_ERROR:
			return "SSL_HANDSHAKE_ERROR"
		_:
			return "UNKNOWN"