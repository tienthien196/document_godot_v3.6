extends Node

func _ready():
    # Khởi tạo một PoolStringArray từ mảng thông thường
    var arr = PoolStringArray(["apple", "banana", "orange"])

    # 1. append(string) - Thêm phần tử vào cuối mảng
    arr.append("grape")
    print("Sau khi append('grape'): ", arr)

    # 2. push_back(string) - Tương tự append
    arr.push_back("mango")
    print("Sau khi push_back('mango'): ", arr)

    # 3. insert(index, string) - Chèn phần tử vào vị trí cụ thể
    arr.insert(2, "kiwi")
    print("Sau khi insert(2, 'kiwi'): ", arr)

    # 4. remove(index) - Xóa phần tử tại index
    arr.remove(1)
    print("Sau khi remove(1): ", arr)

    # 5. set(index, string) - Sửa giá trị tại index
    arr.set(0, "pineapple")
    print("Sau khi set(0, 'pineapple'): ", arr)

    # 6. fill(string) - Gán tất cả phần tử thành cùng giá trị
    var filled_arr = PoolStringArray()
    filled_arr.resize(3)
    filled_arr.fill("default")
    print("filled_arr sau fill('default'): ", filled_arr)

    # 7. clear() - Xóa toàn bộ phần tử
    filled_arr.clear()
    print("filled_arr sau clear(): ", filled_arr)

    # 8. empty() - Kiểm tra mảng trống
    print("filled_arr có trống không? ", filled_arr.empty())

    # 9. size() - Lấy số lượng phần tử
    print("arr.size(): ", arr.size())

    # 10. has(string) - Kiểm tra sự tồn tại của phần tử
    print("arr có chứa 'kiwi' không? ", arr.has("kiwi"))

    # 11. find(string, from_index) - Tìm kiếm phần tử
    print("Vị trí của 'kiwi': ", arr.find("kiwi"))
    print("Tìm 'kiwi' từ index 2: ", arr.find("kiwi", 2))

    # 12. rfind(string, from_index) - Tìm ngược từ vị trí cho trước
    arr.append("kiwi")
    print("arr.rfind('kiwi') (từ cuối): ", arr.rfind("kiwi"))

    # 13. count(string) - Đếm số lần xuất hiện
    print("Số lần 'kiwi' xuất hiện: ", arr.count("kiwi"))

    # 14. sort() - Sắp xếp mảng theo thứ tự tăng dần
    arr.sort()
    print("arr sau sort(): ", arr)

    # 15. invert() - Đảo ngược thứ tự mảng
    arr.invert()
    print("arr sau invert(): ", arr)

    # 16. join(delimiter) - Nối các phần tử thành chuỗi với phân cách
    var joined_str = arr.join(", ")
    print("arr.join(', '): ", joined_str)

    # 17. resize(size) - Thay đổi kích thước mảng
    arr.resize(2)
    print("arr sau resize(2): ", arr)

    # 18. append_array(another_pool_string_array) - Nối thêm một PoolStringArray khác
    var more_fruits = PoolStringArray(["watermelon", "strawberry"])
    arr.append_array(more_fruits)
    print("arr sau append_array(['watermelon', 'strawberry']): ", arr)

    # 19. Truy cập phần tử bằng chỉ số
    if arr.size() > 0:
        print("Phần tử đầu tiên: ", arr[0])