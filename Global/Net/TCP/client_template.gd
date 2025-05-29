extends Node

var stream_peer = StreamPeerTCP.new()

func _ready():
	var ip = "127.0.0.1"
	var port = 1234

	print("🔌 Đang kết nối đến %s:%d..." % [ip, port])
	var err = stream_peer.connect_to_host(ip, port)

	if err != OK:
		print("❌ Kết nối thất bại!")
		return

	print("🟢 Đã kết nối thành công đến server!")

	# Gửi chuỗi UTF-8
	var utf8_msg = "Xin chào từ client!"
	stream_peer.put_utf8_string(utf8_msg)
	print("📤 Gửi chuỗi UTF-8:", utf8_msg)

	# Gửi số nguyên 32-bit không dấu
	var number: int = 12345
	stream_peer.put_u32(number)
	print("🔢 Gửi số u32:", number)

	# Gửi một biến Variant (VD: mảng hoặc dictionary)
	var variant_data = {
		"name": "Alice",
		"age": 25,
		"skills": ["Godot", "Networking"]
	}
	stream_peer.put_var(variant_data)
	print("📦 Gửi Variant:", variant_data)

	# Chờ phản hồi từ server
	yield(get_tree().create_timer(1.0), "timeout")
	var available = stream_peer.get_available_bytes()
	if available > 0:
		var response = stream_peer.get_utf8_string()
		print("📩 Phản hồi từ server:", response)

	#stream_peer.disconnect_from_host()
	#print("👋 Đã ngắt kết nối.")
