extends Node

var tcp = StreamPeerTCP.new()
var ssl = StreamPeerSSL.new()

func _ready():
    print("🟠 Đang kết nối tới server...")

    var error = tcp.connect_to_host("127.0.0.1", 8080)
    if error != OK:
        print("🔴 Không thể kết nối TCP:", error)
        return

    print("🔵 Đang thiết lập kết nối SSL...")
    error = ssl.connect_to_stream(tcp, false, "localhost")
    if error != OK:
        print("🔴 Lỗi khi kết nối SSL:", error)
        return

    while ssl.get_status() == ssl.STATUS_HANDSHAKING:
        ssl.poll()
        yield(Engine.get_singleton("SceneTree"), "idle_frame")

    if ssl.get_status() == ssl.STATUS_CONNECTED:
        print("🟢 Kết nối SSL thành công!")
        start_communication()
    else:
        print("🔴 Kết nối thất bại:", ssl.get_status())

func start_communication():
    var msg = ssl.get_data(ssl.get_available_bytes())
    print("📩 Chào mừng từ server:", msg[1].get_string_from_utf8())

    while ssl.get_status() == ssl.STATUS_CONNECTED:
        ssl.poll()
        var input = Input.get_line()
        if input != "":
            ssl.put_string(input + "\n")

        if ssl.get_available_bytes() > 0:
            var reply = ssl.get_data(ssl.get_available_bytes())[1]
            print("📩 Phản hồi từ server: ", reply.get_string_from_utf8())

        yield(Engine.get_singleton("SceneTree"), "idle_frame")

    print("🚫 Kết nối đã đóng.")