extends Node

var tcp_server = TCP_Server.new()
var ssl_server = StreamPeerSSL.new()

onready var cert = load("res://cert.pem") as X509Certificate
onready var key = load("res://key.pem") as CryptoKey

func _ready():
	if tcp_server.listen(8080) != OK:
		print("Không thể bắt đầu server trên cổng 8080")
		return

	print("🟢 Server đang lắng nghe trên cổng 8080...")

	set_process(true)

func _process(delta):
	if tcp_server.is_connection_available():
		var tcp_peer = tcp_server.take_connection()
		print("🟡 Một client TCP đã kết nối!")

		# Bắt đầu quá trình chấp nhận SSL
		var error = ssl_server.accept_stream(tcp_peer, key, cert)
		if error != OK:
			print("🔴 Lỗi khi khởi tạo SSL:", error)
			return

		print("🔵 Đang bắt tay SSL...")
		while ssl_server.get_status() == ssl_server.STATUS_HANDSHAKING:
			ssl_server.poll()
			yield(Engine.get_singleton("SceneTree"), "idle_frame")

		if ssl_server.get_status() == ssl_server.STATUS_CONNECTED:
			print("🟢 Kết nối SSL thành công!")
			call_deferred("handle_client", ssl_server.duplicate())
		else:
			print("🔴 Lỗi SSL:", ssl_server.get_status())
			ssl_server.disconnect_from_stream()

func handle_client(peer):
	peer.put_string("Chào mừng bạn đến với SSL Server!\n")

	while peer.get_status() == peer.STATUS_CONNECTED:
		peer.poll()
		if peer.get_available_bytes() > 0:
			var data = peer.get_data(peer.get_available_bytes())[1] as PoolByteArray
			var text = data.get_string_from_utf8()
			print("📩 Nhận từ client: ", text)

			peer.put_string("Server nhận được: " + text + "\n")

		yield(Engine.get_singleton("SceneTree"), "idle_frame")

	print("🚫 Client đã ngắt kết nối.")
