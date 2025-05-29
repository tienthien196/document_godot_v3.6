extends Node

var tcp = StreamPeerTCP.new()
var ssl = StreamPeerSSL.new()

const HOST = "httpbin.org"
const PORT = 443

func _ready():
	print("=== STARTING HTTPBIN TEST CLIENT ===\n")

	# Bắt đầu kết nối TCP
	var error = tcp.connect_to_host(HOST, PORT)
	if error != OK:
		print("❌ Lỗi kết nối TCP:", error)
		return

	print("🔌 Đã kết nối TCP tới %s:%d" % [HOST, PORT])

	# Bắt đầu SSL handshake
	error = ssl.connect_to_stream(tcp, true, HOST)
	if error != OK:
		print("❌ Lỗi connect_to_stream:", error)
		return

	print("🔐 Đang bắt tay SSL...")

	while ssl.get_status() == ssl.STATUS_HANDSHAKING:
		ssl.poll()
		yield(Engine.get_singleton("SceneTree"), "idle_frame")

	if ssl.get_status() != ssl.STATUS_CONNECTED:
		print("❌ Lỗi SSL. Trạng thái:", status_string(ssl.get_status()))
		return

	print("✅ Kết nối SSL thành công!")

	# Ví dụ 1: Gửi GET /get
	send_http_request("GET", "/get", {})

	# Ví dụ 2: Gửi POST /post
	send_http_request("POST", "/post", {
		"key1": "value1",
		"key2": "value2"
	})

	# Ví dụ 3: Gửi GET /headers
	send_http_request("GET", "/headers", {})

	# Ví dụ 4: Gửi GET /status/404
	send_http_request("GET", "/status/404", {})

	# Ví dụ 5: Gửi GET /cookies
	send_http_request("GET", "/cookies", {})

	# Ví dụ 6: Gửi GET /cookies/set?name=hello&value=world
	send_http_request("GET", "/cookies/set?name=hello&value=world", {})

	# Ngắt kết nối
	ssl.disconnect_from_stream()
	print("\n👋 Đã ngắt kết nối.")

func send_http_request(method, path, data={}):
	var body = ""
	var content_length = 0

	if method == "POST" or method == "PUT":
		body = JSON.print(data)
		content_length = body.length()

	var content_length_header = ""
	if content_length > 0:
		content_length_header = "Content-Length: %d\n" % content_length

	var request = method + " " + path + " HTTP/1.1\n"
	request += "Host: " + HOST + "\n"
	request += "Content-Type: application/json\n"
	request += content_length_header
	request += "Connection: close\n"
	request += "\n"
	if content_length > 0:
		request += body
	request += "\n"

	ssl.put_string(request)
	print("📤 [%s %s] Đã gửi yêu cầu." % [method, path])

	# Nhận phản hồi
	var response = ""
	var total_received = ""

	while ssl.get_status() == ssl.STATUS_CONNECTED:
		ssl.poll()
		var available = ssl.get_available_bytes()
		if available > 0:
			var result = ssl.get_data(available)
			if result[0] == OK:
				var data_array = result[1]
				if data_array.size() > 0:
					response += data_array.get_string_from_utf8()
		else:
			# Dừng lại một chút để server kịp trả lời
			yield(get_tree().create_timer(0.1), "timeout")

		# Ngắt vòng lặp nếu đã nhận xong dữ liệu (Connection: close)
		if response.find("\r\n\r\n") != -1 and response.length() > 200:
			break

	# Trích xuất phần thân HTTP response
	var body_start = response.find("\r\n\r\n")
	if body_start != -1:
		total_received = response.substr(body_start + 4, response.length())

	print("📩 [%s %s] Phản hồi:\n%s" % [method, path, total_received])
# Hàm hỗ trợ: chuyển trạng thái SSL thành chuỗi
func status_string(status):
	match status:
		ssl.STATUS_DISCONNECTED:
			return "STATUS_DISCONNECTED"
		ssl.STATUS_HANDSHAKING:
			return "STATUS_HANDSHAKING"
		ssl.STATUS_CONNECTED:
			return "STATUS_CONNECTED"
		ssl.STATUS_ERROR:
			return "STATUS_ERROR"
		ssl.STATUS_ERROR_HOSTNAME_MISMATCH:
			return "STATUS_ERROR_HOSTNAME_MISMATCH"
	return "UNKNOWN STATUS"
