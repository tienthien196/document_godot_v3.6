extends Node2D

# Biến lưu đối tượng WebRTCDataChannel
var data_channel: WebRTCDataChannel

func _ready():
    # Giả lập tạo một kênh WebRTC DataChannel (ví dụ từ WebRTCConnection)
    data_channel = _create_data_channel()

    # Thêm timer để theo dõi trạng thái kết nối định kỳ
    get_tree().create_timer(1.0, true).connect("timeout", self, "_poll_data_channel")

func _create_data_channel() -> WebRTCDataChannel:
    var channel = WebRTCDataChannel.new()

    # Thiết lập thông số ban đầu cho kênh
    channel.set_write_mode(WebRTCDataChannel.WRITE_MODE_TEXT) # Mặc định gửi dưới dạng text
    channel.poll() # Hàm này chưa dùng đến nhưng vẫn gọi để đảm bảo tương thích

    print("🏷 Label của kênh:", channel.get_label())
    print("🔁 Có phải kênh đã thỏa thuận trước (negotiated):", channel.is_negotiated())
    print("🔢 ID kênh:", channel.get_id())
    print("🔄 Có gửi dữ liệu theo thứ tự (ordered):", channel.is_ordered())

    return channel

func _poll_data_channel():
    match data_channel.get_ready_state():
        WebRTCDataChannel.STATE_CONNECTING:
            print("🟡 Trạng thái: CONNECTING - Đang cố gắng thiết lập kết nối...")

        WebRTCDataChannel.STATE_OPEN:
            print("🟢 Trạng thái: OPEN - Kênh sẵn sàng gửi/nhận dữ liệu.")

            # Gửi dữ liệu mẫu
            if data_channel.write_mode == WebRTCDataChannel.WRITE_MODE_TEXT:
                data_channel.put_packet("Hello từ Godot!".to_utf8())
                print("📩 Đã gửi gói tin văn bản.")
            else:
                var packet = PoolByteArray([72, 101, 108, 108, 111]) # "Hello" dạng binary
                data_channel.put_packet(packet)
                print("📩 Đã gửi gói tin nhị phân.")

            # Nhận dữ liệu nếu có
            if data_channel.get_available_packet_count() > 0:
                var received = data_channel.get_packet()
                if data_channel.was_string_packet():
                    print("📥 Nhận được gói văn bản:", received.get_string_from_utf8())
                else:
                    print("📥 Nhận được gói nhị phân:", received)

        WebRTCDataChannel.STATE_CLOSING:
            print("🟠 Trạng thái: CLOSING - Kênh đang được đóng...")

        WebRTCDataChannel.STATE_CLOSED:
            print("🔴 Trạng thái: CLOSED - Kênh đã bị đóng hoặc thất bại.")
            get_tree().get_nodes_in_group("timers").call("stop") # Dừng timer

func _input(event):
    # Nhấn phím ESC để đóng kênh
    if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
        _close_data_channel()

func _close_data_channel():
    if data_channel:
        data_channel.close()
        print("🛑 Kênh đã được đóng.")

func _exit_tree():
    # Luôn đảm bảo đóng kênh khi node bị hủy
    if data_channel and data_channel.get_ready_state() != WebRTCDataChannel.STATE_CLOSED:
        data_channel.close()