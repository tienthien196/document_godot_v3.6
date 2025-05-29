extends Node

var http = HTTPClient.new()

func _ready():
	print("Đang kết nối đến server...")
	
	#http.set_blocking_mode(true)
	# Kết nối tới localhost:5000
	var err = http.connect_to_host("localhost", 5000)
	if err != OK:
		print("Không thể kết nối đến server")
		return

	# Chờ kết nối hoàn tất
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		yield(Engine.get_main_loop(), "idle_frame")
	var headers = ["Content-Type: application-json"]
	# Gửi yêu cầu GET đến /api/player
	http.request(HTTPClient.METHOD_GET, "/api/player", headers)

	# Đợi phản hồi
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		http.poll()
		yield(Engine.get_main_loop(), "idle_frame")

	# Kiểm tra trạng thái phản hồi
	if http.get_status() == HTTPClient.STATUS_BODY:
		var body = http.read_response_body_chunk()
		var response_text = body.get_string_from_utf8()
		print("Dữ liệu từ server:", response_text)

		# Phân tích JSON
		var json = JSON.parse(response_text)
		if json.error:
			print("Lỗi phân tích JSON")
			return

		var data = json.result
		print("Tên người chơi: ", data["name"])
		print("Điểm số: ", data["score"])
		print("Cấp độ: ", data["level"])
		print("Vật phẩm: ", data["items"])

	else:
		print("Không nhận được dữ liệu. Trạng thái: ", http.get_status())
