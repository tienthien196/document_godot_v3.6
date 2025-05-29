extends Node

var tcp_server = TCP_Server.new()
var client_peer: StreamPeerTCP

func _ready():
	var error = tcp_server.listen(1234)
	if error == OK:
		print("🟢 TCP Server đang lắng nghe trên cổng 1234...")
		call_deferred("_check_connections")
	else:
		print("🔴 Lỗi: Không thể bắt đầu lắng nghe!")

func _check_connections():
	if tcp_server.is_connection_available():
		client_peer = tcp_server.take_connection()
		print("🔵 Có client kết nối!")
		print(client_peer.get_connected_host())
		print(client_peer.get_connected_port())
		call_deferred("_process_client")

	yield(get_tree().create_timer(1.0), "timeout")
	print("truee van cahy tiep ")
	call_deferred("_check_connections")

func _process_client():
	while client_peer.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		var available = client_peer.get_available_bytes()
		if available > 0:
			# Đọc chuỗi UTF-8
			var msg_utf8 = client_peer.get_utf8_string()
			print("📩 Nhận được chuỗi UTF-8:", msg_utf8)

			# Đọc số nguyên không dấu 32-bit
			var num_u32 = client_peer.get_u32()
			print("🔢 Nhận được số u32:", num_u32)

			# Đọc một biến Variant
			var received_variant = client_peer.get_var()
			print("📦 Nhận được Variant:", received_variant)

			# Gửi phản hồi về client
			var response = "Server đã nhận được tất cả!"
			client_peer.put_utf8_string(response)
		#yield(get_tree().create_timer(0.1), "timeout")

	print("🟡 Client đã ngắt kết nối.")
	tcp_server.stop()
	print("server close .........the end")
	get_tree().quit()
