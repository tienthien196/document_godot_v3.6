extends Node2D

func _ready():
    # Khởi tạo một NodePath từ chuỗi
    var path = NodePath("Path2D/PathFollow2D/Sprite:texture:size")
    print("Khởi tạo NodePath:", path)

    # get_name_count()
    print("get_name_count():", path.get_name_count())  # 3

    # get_name(idx)
    for i in range(path.get_name_count()):
        print("get_name(%d): %s" % [i, path.get_name(i)])
        # Path2D
        # PathFollow2D
        # Sprite

    # get_subname_count()
    print("get_subname_count():", path.get_subname_count())  # 2

    # get_subname(idx)
    for i in range(path.get_subname_count()):
        print("get_subname(%d): %s" % [i, path.get_subname(i)])
        # texture
        # size

    # get_concatenated_subnames()
    print("get_concatenated_subnames():", path.get_concatenated_subnames())  # texture:size

    # is_absolute()
    var abs_path = NodePath("/root/MainScene/Player")
    print("is_absolute() trên đường dẫn tuyệt đối?", abs_path.is_absolute())  # true
    print("is_absolute() trên đường dẫn tương đối?", path.is_absolute())  # false

    # is_empty()
    var empty_path = NodePath("")
    print("is_empty() trên NodePath rỗng?", empty_path.is_empty())  # true
    print("is_empty() trên path bình thường?", path.is_empty())  # false

    # get_as_property_path()
    var prop_path = path.get_as_property_path()
    print("get_as_property_path():", prop_path)  # :Path2D/PathFollow2D/Sprite:texture:size

    # Constructor trực tiếp từ chuỗi
    var direct_path = NodePath("A/B/C:D/E")
    print("Constructor từ chuỗi:", direct_path)