extends Node2D

func _ready():
    # Khởi tạo mảng ban đầu
    var array = [10, 20, 30, 40]
    print("Khởi tạo mảng:", array)

    # append(value)
    array.append(50)
    print("Sau khi append(50):", array)

    # append_array(array)
    var another_array = [60, 70]
    array.append_array(another_array)
    print("Sau khi append_array([60, 70]):", array)

    # back()
    print("back():", array.back())

    # bsearch(value, before=true)
    array.sort()
    print("Mảng sau khi sort để dùng bsearch:", array)
    print("bsearch(30):", array.bsearch(30))

    # bsearch_custom(value, obj, func, before=true)
    func compare(a, b):
        return a < b

    print("bsearch_custom(30, self, 'compare'):", array.bsearch_custom(30, self, "compare"))

    # clear()
    array.clear()
    print("Sau khi clear():", array)

    # count(value)
    array = [10, 20, 20, 30, 20]
    print("count(20):", array.count(20))

    # duplicate(deep=false)
    var copied_array = array.duplicate()
    print("duplicate():", copied_array)

    # empty()
    print("empty() trên mảng rỗng?", [].empty())

    # erase(value)
    array.erase(20)
    print("Sau khi erase(20):", array)

    # fill(value)
    array.fill(99)
    print("Sau khi fill(99):", array)

    # find(what, from=0)
    print("find(99):", array.find(99))

    # find_last(value)
    print("find_last(99):", array.find_last(99))

    # front()
    print("front():", array.front())

    # has(value)
    print("has(99)?", array.has(99))

    # hash()
    print("hash():", array.hash())

    # insert(position, value)
    array.insert(1, 88)
    print("Sau khi insert(1, 88):", array)

    # invert()
    array.invert()
    print("Sau khi invert():", array)

    # max()
    print("max():", array.max())

    # min()
    print("min():", array.min())

    # pick_random()
    print("pick_random():", array.pick_random())

    # pop_at(position)
    print("pop_at(0):", array.pop_at(0))
    print("Sau khi pop_at(0):", array)

    # pop_back()
    print("pop_back():", array.pop_back())
    print("Sau khi pop_back():", array)

    # pop_front()
    print("pop_front():", array.pop_front())
    print("Sau khi pop_front():", array)

    # push_back(value)
    array.push_back(100)
    print("push_back(100):", array)

    # push_front(value)
    array.push_front(5)
    print("push_front(5):", array)

    # remove(position)
    array.remove(0)
    print("Sau khi remove(0):", array)

    # resize(size)
    array.resize(5)
    print("resize(5):", array)

    # rfind(what, from=-1)
    print("rfind(100):", array.rfind(100))

    # shuffle()
    array.shuffle()
    print("shuffle():", array)

    # size()
    print("size():", array.size())

    # slice(begin, end, step=1, deep=false)
    var sliced = array.slice(0, 2)
    print("slice(0, 2):", sliced)

    # sort()
    array.sort()
    print("sort():", array)

    # sort_custom(obj, func)
    class CustomSorter:
        static func custom_compare(a, b):
            return a > b

    array.sort_custom(CustomSorter, "custom_compare")
    print("sort_custom(custom_compare):", array)