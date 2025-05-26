# ResourceLoader: Là một singleton giúp tải tài nguyên từ hệ thống tệp.
# ResourceInteractiveLoader: Dùng để tải tài nguyên theo từng bước (interactive), 
# hữu ích khi cần hiển thị thanh tiến trình hoặc kiểm soát chi tiết quá trình tải.



extends Node

func _ready():
    # Đường dẫn ví dụ đến một file tài nguyên (cần tồn tại trong dự án)
    var resource_path = "res://icon.png"

    # 1.Kiểm tra xem có tài nguyên nào ở đường dẫn này không?  ResourceLoader.exists(path, type_hint) -
    print("Tài nguyên tồn tại? ", ResourceLoader.exists(resource_path))

    # 2.- Lấy danh sách phụ thuộc của tài nguyên - ResourceLoader.get_dependencies(path) 
    print("Phụ thuộc của tài nguyên: ", ResourceLoader.get_dependencies(resource_path))

    # 3.- Lấy danh sách đuôi file hỗ trợ cho loại tài nguyên  ResourceLoader.get_recognized_extensions_for_type(type) 
    print("Các đuôi hỗ trợ cho Texture: ", ResourceLoader.get_recognized_extensions_for_type("Texture"))

    # 4.- Kiểm tra tài nguyên đã được cache chưa  ResourceLoader.has_cached(path) 
    print("Đã cache tài nguyên chưa? ", ResourceLoader.has_cached(resource_path))

    # 5.- Tải tài nguyên  ResourceLoader.load(path, type_hint, no_cache) 
    var res = ResourceLoader.load(resource_path)
    if res:
        print("Tải thành công tài nguyên: ", res)
    else:
        print("Không thể tải tài nguyên!")

    # 6. ResourceLoader.set_abort_on_missing_resources(abort) - Bật/tắt việc dừng khi thiếu sub-resource
    ResourceLoader.set_abort_on_missing_resources(false)

    # 7. ResourceLoader.load_interactive(path, type_hint, no_cache) - Tải tài nguyên theo từng bước
    var interactive_loader = ResourceLoader.load_interactive(resource_path)
    if not interactive_loader:
        print("Không thể bắt đầu tải tương tác!")
        return

    # 8. ResourceInteractiveLoader.no_subresource_cache - Không cache các sub-resource
    interactive_loader.no_subresource_cache = false

    # 9. ResourceInteractiveLoader.poll() - Bắt đầu tải từng phần
    var error = OK
    while error == OK:
        error = interactive_loader.poll()
        print("Giai đoạn hiện tại: ", interactive_loader.get_stage(), "/", interactive_loader.get_stage_count())

    if error == ERR_FILE_EOF:
        print("Tải xong! Tài nguyên:", interactive_loader.get_resource())
    else:
        print("Lỗi khi tải:", error)

    # 10. ResourceInteractiveLoader.wait() - Tải toàn bộ ngay lập tức sau khi poll
    var wait_error = interactive_loader.wait()
    if wait_error == ERR_FILE_EOF:
        print("Tải hoàn tất bằng wait().")
    else:
        print("Lỗi khi dùng wait():", wait_error)