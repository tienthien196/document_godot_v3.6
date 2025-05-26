extends Node

func _ready():
    # Tạo một tài nguyên tạm thời để lưu (ví dụ: Texture)
    var texture = ImageTexture.new()
    var image = Image.new()
    image.create(64, 64, false, Image.FORMAT_RGBA8)
    image.fill(Color(1, 0, 0))  # Màu đỏ
    texture.create_from_image(image)

    # Đường dẫn lưu tài nguyên
    var save_path = "user://example_texture.tres"

    # 1. ResourceSaver.get_recognized_extensions(resource) - Lấy danh sách đuôi file hỗ trợ
    var extensions = ResourceSaver.get_recognized_extensions(texture)
    print("Các đuôi file hỗ trợ cho Texture: ", extensions)

    # 2. ResourceSaver.save(path, resource, flags) - Lưu tài nguyên với các tùy chọn
    var flags = ResourceSaver.FLAG_RELATIVE_PATHS | ResourceSaver.FLAG_BUNDLE_RESOURCES | ResourceSaver.FLAG_CHANGE_PATH
    var error = ResourceSaver.save(save_path, texture, flags)

    if error == OK:
        print("Lưu tài nguyên thành công tại: ", ProjectSettings.localize_path(save_path))
    else:
        print("Lỗi khi lưu tài nguyên!")