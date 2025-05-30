extends Node2D

func _ready():
    # Khởi tạo một PoolByteArray từ mảng thông thường
    var pba = PoolByteArray([72, 101, 108, 108, 111])  # "Hello" dưới dạng byte
    print("Khởi tạo PoolByteArray:", pba)

    # append(byte)
    pba.append(33)  # Thêm dấu chấm than '!'
    print("Sau khi append(33):", pba)

    # append_array(PoolByteArray)
    var extra = PoolByteArray([32, 87, 111, 114, 108, 100])  # " World"
    pba.append_array(extra)
    print("Sau khi append_array():", pba)

    # clear()
    var temp = pba.duplicate()  # Sao chép trước khi clear
    temp.clear()
    print("Sau khi clear():", temp)

    # fill(byte)
    temp = PoolByteArray([0, 0, 0])
    temp.fill(255)
    print("Sau khi fill(255):", temp)

    # push_back(byte)
    temp.push_back(0)
    print("Sau khi push_back(0):", temp)

    # insert(idx, byte)
    temp.insert(1, 128)
    print("Sau khi insert(1, 128):", temp)

    # remove(idx)
    temp.remove(2)
    print("Sau khi remove(2):", temp)

    # resize(size)
    temp.resize(5)
    print("Sau khi resize(5):", temp)

    # set(idx, byte)
    temp.set(3, 64)
    print("Sau khi set(3, 64):", temp)

    # invert()
    temp.invert()
    print("Sau khi invert():", temp)

    # sort()
    temp.sort()
    print("Sau khi sort():", temp)

    # subarray(from, to)
    var sub = pba.subarray(0, 5)
    print("subarray(0, 5):", sub)

    # size()
    print("size():", pba.size())

    # count(value)
    print("count(32):", pba.count(32))

    # find(value, from)
    print("find(87, 0):", pba.find(87, 0))

    # rfind(value, from)
    print("rfind(108):", pba.rfind(108))  # vị trí cuối cùng của ký tự 'l'

    # has(value)
    print("has(33)?", pba.has(33))  # true

    # empty()
    print("empty()? trên mảng rỗng:", PoolByteArray().empty())

    # get_string_from_ascii()
    print("get_string_from_ascii():", pba.get_string_from_ascii())  # "Hello World!"

    # get_string_from_utf8()
    print("get_string_from_utf8():", pba.get_string_from_utf8())  # "Hello World!"

    # hex_encode()
    print("hex_encode():", pba.hex_encode())  # "48656c6c6f20576f726c6421"

    # compress và decompress
    var compressed = pba.compress(1)  # CompressionMode.DEFLATE
    print("Kích thước sau nén:", compressed.size())
    var decompressed = compressed.decompress(pba.size(), 1)
    print("Kích thước sau giải nén:", decompressed.size())
    print("Giải nén thành công?", decompressed == pba)

    # duplicate()
    var copy = pba.duplicate()
    print("duplicate():", copy)

    # Ví dụ về gán lại khi dùng trong Array/Dictionary
    var arr = [PoolByteArray()]
    arr[0].append(123)  # ❌ Không hoạt động như mong muốn
    print("arr (sai cách):", arr)  # [[], không có giá trị nào]

    var pool_array = arr[0]
    pool_array.append(123)
    arr[0] = pool_array  # ✅ Cách đúng
    print("arr (đúng cách):", arr)  # [[123]]