extends Node

func _ready():
    print("=== STARTING StreamPeerBuffer DEMO ===\n")

    # Tạo một StreamPeerBuffer mới
    var buffer = StreamPeerBuffer.new()

    # Ghi dữ liệu vào buffer
    buffer.put_u8(255)
    buffer.put_u16(65534)
    buffer.put_string("Hello World")
    buffer.put_float(3.14159)

    # In ra kích thước hiện tại và vị trí con trỏ
    print("After writing:")
    print("Current position: ", buffer.get_position())  # 1 + 2 + (4 + 11) + 4 = 22
    print("Current size: ", buffer.get_size())          # 22 bytes

    # In ra mảng byte đã ghi
    print("\nRaw data in buffer:", buffer.data_array)

    # Sao chép buffer để thử nghiệm mà không làm hỏng dữ liệu gốc
    var buffer_copy = buffer.duplicate()

    # Di chuyển con trỏ về đầu để đọc lại
    buffer.seek(0)

    # Đọc lại dữ liệu theo đúng thứ tự đã ghi
    print("\nReading data from buffer:")
    print("u8: ", buffer.get_u8())            # 255
    print("u16: ", buffer.get_u16())          # 65534
    print("string: ", buffer.get_string())    # Hello World
    print("float: ", buffer.get_float())      # ~3.14159

    # Kiểm tra vị trí sau khi đọc
    print("\nAfter reading:")
    print("Current position: ", buffer.get_position())  # 22
    print("Current size: ", buffer.get_size())          # 22

    # Thử resize buffer nhỏ hơn
    buffer.resize(10)
    print("\nAfter resizing to 10 bytes:")
    print("Current size: ", buffer.get_size())         # 10
    print("Current position: ", buffer.get_position()) # Vẫn là 22 → vượt quá kích thước mới!

    # Nếu tiếp tục đọc/sẽ lỗi, nên cần seek lại
    buffer.seek(0)
    print("Position after seek(0): ", buffer.get_position())

    # Xóa buffer
    buffer.clear()
    print("\nAfter clear():")
    print("Size: ", buffer.get_size())           # 0
    print("Position: ", buffer.get_position())   # 0

    # Truy cập trực tiếp data_array (thiết lập và lấy ra)
    buffer.data_array = PoolByteArray([1, 2, 3, 4])
    print("\ndata_array set to [1, 2, 3, 4]")
    print("data_array: ", buffer.get_data_array())

    print("\n=== END OF DEMO ===")