extends Node2D

func _ready():
    # Khởi tạo một Dictionary mẫu
    var my_dict = {
        "name": "Alice",
        "age": 25,
        "is_student": true,
        "hobbies": ["reading", "coding"]
    }
    print("Khởi tạo Dictionary:", my_dict)

    # has(key)
    print("has('name')?", my_dict.has("name"))  # true
    print("has('gender')?", my_dict.has("gender"))  # false

    # get(key, default)
    print("get('age'):", my_dict.get("age"))  # 25
    print("get('gender', 'unknown'):", my_dict.get("gender", "unknown"))  # unknown

    # get_or_add(key, default)
    print("get_or_add('gender', 'female'):", my_dict.get_or_add("gender", "female"))  # female
    print("Sau khi get_or_add('gender'):", my_dict)  # gender: female đã được thêm vào

    # erase(key)
    print("erase('is_student'):", my_dict.erase("is_student"))  # true
    print("Sau khi erase('is_student'):", my_dict)

    # find_key(value)
    print("find_key('Alice'):", my_dict.find_key("Alice"))  # name
    print("find_key('xyz'):", my_dict.find_key("xyz"))  # null

    # keys()
    print("keys():", my_dict.keys())  # ['name', 'age', 'hobbies', 'gender']

    # values()
    print("values():", my_dict.values())  # ['Alice', 25, ['reading', 'coding'], 'female']

    # size()
    print("size():", my_dict.size())  # 4

    # empty()
    print("empty()? trên dict trống:", {}.empty())  # true

    # clear()
    my_dict.clear()
    print("Sau khi clear():", my_dict)  # {}

    # duplicate(deep=false)
    var original = {"a": 1, "b": [2, 3], "c": {"nested": 4}}
    var shallow_copy = original.duplicate()
    var deep_copy = original.duplicate(true)
    shallow_copy["b"].append(99)
    deep_copy["b"].append(88)
    print("original['b'] sau khi thay đổi shallow_copy:", original["b"])  # [2, 3, 99]
    print("deep_copy['b']:", deep_copy["b"])  # [2, 3, 88]

    # hash()
    var dict1 = {"x": 10, "y": 20}
    var dict2 = {"x": 10, "y": 20}
    print("hash() có giống nhau không?", dict1.hash() == dict2.hash())  # true

    # merge(dictionary, overwrite=false)
    var base = {"a": 1, "b": 2}
    var extra = {"b": 20, "c": 3}
    base.merge(extra)
    print("merge (overwrite=false):", base)  # b giữ nguyên giá trị cũ (1), c được thêm vào
    base.merge(extra, true)
    print("merge (overwrite=true):", base)  # b bị ghi đè thành 20

    # has_all(array of keys)
    var user = {"id": 1, "username": "user1", "email": "user@example.com"}
    print("has_all(['id', 'username'])?", user.has_all(["id", "username"]))  # true
    print("has_all(['id', 'password'])?", user.has_all(["id", "password"]))  # false