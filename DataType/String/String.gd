extends Node2D

func _ready():
    # Khởi tạo một chuỗi mẫu
    var s = "Hello, World!"
    print("Chuỗi gốc:", s)

    # 1. Các hàm khởi tạo từ kiểu khác
    var from_int = String(123)
    var from_float = String(3.14)
    var from_array = String(["One", "Two"])
    var from_dict = String({"a": 1})
    print("Khởi tạo từ số nguyên:", from_int)
    print("Khởi tạo từ số thực:", from_float)
    print("Khởi tạo từ mảng:", from_array)
    print("Khởi tạo từ Dictionary:", from_dict)

    # 2. begins_with(text)
    print("begins_with('Hello')?", s.begins_with("Hello"))  # true

    # 3. bigrams()
    print("bigrams():", s.bigrams())  # ["He", "el", "ll", "lo", "o,", ", ", " W", "Wo", "or", "rl", "ld"]

    # 4. c_escape()
    print("c_escape():", "Hello\nWorld".c_escape())  # Hello\nWorld

    # 5. c_unescape()
    print("c_unescape():", "Hello\\nWorld".c_unescape())  # Hello
                                                          # World

    # 6. capitalize()
    print("capitalize():", "hello world".capitalize())  # Hello World

    # 7. casecmp_to(to)
    print("casecmp_to('Apple'):", "Banana".casecmp_to("Apple"))  # 1

    # 8. count(what, from, to)
    print("count('l'):", s.count("l"))  # 3

    # 9. countn(what, from, to)
    print("countn('L'):", s.countn("L"))  # 3

    # 10. dedent()
    print("dedent():", "    Hello\n    World".dedent())  # Hello\nWorld

    # 11. empty()
    print("empty()? trên chuỗi trống:", "".empty())  # true

    # 12. ends_with(text)
    print("ends_with('!')?", s.ends_with("!"))  # true

    # 13. erase(position, chars)
    var temp = s
    temp.erase(5, 2)
    print("erase(5, 2):", temp)  # Hello World

    # 14. find(what, from)
    print("find('W'):", s.find("W"))  # 7

    # 15. find_last(what)
    print("find_last('l'):", s.find_last("l"))  # 9

    # 16. findn(what, from)
    print("findn('W'):", s.findn("W"))  # 7

    # 17. format(values, placeholder)
    var formatted = "{0} is {1}".format(["Godot", "awesome"])
    print("format():", formatted)  # Godot is awesome

    # 18. get_base_dir()
    print("get_base_dir():", "res://scenes/level.tscn".get_base_dir())  # res://scenes

    # 19. get_basename()
    print("get_basename():", "res://scenes/level.tscn".get_basename())  # level

    # 20. get_extension()
    print("get_extension():", "res://scenes/level.tscn".get_extension())  # tscn

    # 21. get_file()
    print("get_file():", "res://scenes/level.tscn".get_file())  # level.tscn

    # 22. get_slice(delimiter, slice)
    print("get_slice(',', 1):", s.get_slice(",", 1))  #  World!

    # 23. hash()
    print("hash():", s.hash())

    # 24. hex_to_int()
    print("hex_to_int():", "0xff".hex_to_int())  # 255

    # 25. http_escape()
    print("http_escape():", "Hello World!".http_escape())  # Hello%20World%21

    # 26. http_unescape()
    print("http_unescape():", "Hello%20World%21".http_unescape())  # Hello World!

    # 27. humanize_size(size)
    print("humanize_size(1048576):", String.humanize_size(1048576))  # 1.0 MiB

    # 28. indent(prefix)
    print("indent('> '):", "Line1\nLine2".indent("> "))  # > Line1\n> Line2

    # 29. insert(position, what)
    print("insert(5, ' there'):", s.insert(5, " there"))  # Hello there, World!

    # 30. is_abs_path()
    print("is_abs_path()?", "/home/user/file.txt".is_abs_path())  # true

    # 31. is_rel_path()
    print("is_rel_path()?", "scenes/level.tscn".is_rel_path())  # true

    # 32. is_subsequence_of(text)
    print("is_subsequence_of('Helo Wrd!')?", s.is_subsequence_of("Helo Wrd!"))  # false

    # 33. is_subsequence_ofi(text)
    print("is_subsequence_ofi('HELLO WORLD!')?", s.is_subsequence_ofi("HELLO WORLD!"))  # true

    # 34. is_valid_filename()
    print("is_valid_filename('file.txt')?", "file.txt".is_valid_filename())  # true

    # 35. is_valid_float()
    print("is_valid_float('12.3')?", "12.3".is_valid_float())  # true

    # 36. is_valid_hex_number(with_prefix)
    print("is_valid_hex_number('0x1a')?", "0x1a".is_valid_hex_number(true))  # true

    # 37. is_valid_html_color()
    print("is_valid_html_color('#ff0000')?", "#ff0000".is_valid_html_color())  # true

    # 38. is_valid_identifier()
    print("is_valid_identifier('_valid_name')?", "_valid_name".is_valid_identifier())  # true

    # 39. is_valid_integer()
    print("is_valid_integer('123')?", "123".is_valid_integer())  # true

    # 40. is_valid_ip_address()
    print("is_valid_ip_address('192.168.1.1')?", "192.168.1.1".is_valid_ip_address())  # true

    # 41. join(parts)
    print("join(['One', 'Two']):", ", ".join(["One", "Two"]))  # One, Two

    # 42. json_escape()
    print("json_escape():", "{\"key\": \"value\"}".json_escape())  # "{\"key\": \"value\"}"

    # 43. left(position)
    print("left(5):", s.left(5))  # Hello

    # 44. length()
    print("length():", s.length())  # 13

    # 45. lstrip(chars)
    print("lstrip('H'):", s.lstrip("H"))  # ello, World!

    # 46. match(expr)
    print("match('He*lo')?", s.match("He*lo"))  # true

    # 47. matchn(expr)
    print("matchn('HE*LO')?", s.matchn("HE*LO"))  # true

    # 48. md5_buffer()
    print("md5_buffer():", s.md5_buffer())  # PoolByteArray chứa MD5

    # 49. md5_text()
    print("md5_text():", s.md5_text())  # Mã MD5 dạng chuỗi

    # 50. naturalnocasecmp_to(to)
    print("naturalnocasecmp_to('hello world'):", s.naturalnocasecmp_to("hello world"))  # 0

    # 51. nocasecmp_to(to)
    print("nocasecmp_to('HELLO, WORLD!'):", s.nocasecmp_to("HELLO, WORLD!"))  # 0

    # 52. ord_at(at)
    print("ord_at(0):", s.ord_at(0))  # 72

    # 53. pad_decimals(digits)
    print("pad_decimals(2):", "12.3".pad_decimals(2))  # 12.30

    # 54. pad_zeros(digits)
    print("pad_zeros(5):", "123".pad_zeros(5))  # 00123

    # 55. percent_decode()
    print("percent_decode():", "Hello%20World".percent_decode())  # Hello World

    # 56. percent_encode()
    print("percent_encode():", "Hello World".percent_encode())  # Hello%20World

    # 57. plus_file(file)
    print("plus_file('data.txt'):", "res://folder".plus_file("data.txt"))  # res://folder/data.txt

    # 58. repeat(count)
    print("repeat(2):", s.repeat(2))  # Hello, World!Hello, World!

    # 59. replace(what, forwhat)
    print("replace(',', '.'):", s.replace(",", "."))  # Hello. World!

    # 60. replacen(what, forwhat)
    print("replacen('L', 'X'):", s.replacen("L", "X"))  # HeXXo, WorXd!

    # 61. rfind(what, from)
    print("rfind('l'):", s.rfind("l"))  # 9

    # 62. rfindn(what, from)
    print("rfindn('L'):", s.rfindn("L"))  # 9

    # 63. right(position)
    print("right(5):", s.right(5))  # orld!

    # 64. rsplit(delimiter, allow_empty, maxsplit)
    print("rsplit(',', 1):", s.rsplit(",", 1))  # ["Hello", " World!"]

    # 65. rstrip(chars)
    print("rstrip('!'):", s.rstrip("!"))  # Hello, World

    # 66. sha1_buffer()
    print("sha1_buffer():", s.sha1_buffer())  # SHA-1 dạng PoolByteArray

    # 67. sha1_text()
    print("sha1_text():", s.sha1_text())  # Mã SHA-1 dạng chuỗi

    # 68. sha256_buffer()
    print("sha256_buffer():", s.sha256_buffer())  # SHA-256 dạng PoolByteArray

    # 69. sha256_text()
    print("sha256_text():", s.sha256_text())  # Mã SHA-256 dạng chuỗi

    # 70. similarity(text)
    print("similarity('Helo Wold'):", s.similarity("Helo Wold"))  # ~0.85

    # 71. simplify_path()
    print("simplify_path():", "../scenes/../scenes/level.tscn".simplify_path())  # scenes/level.tscn

    # 72. split(delimiter, allow_empty, maxsplit)
    print("split(','):", s.split(","))  # ["Hello", " World!"]

    # 73. split_floats(delimiter, allow_empty)
    print("split_floats(',', true):", "1.2,3.4,,5.6".split_floats(","))  # [1.2, 3.4, "", 5.6]

    # 74. strip_edges(left, right)
    print("strip_edges():", "   Hello World!   \n\t".strip_edges())  # Hello World!

    # 75. strip_escapes()
    print("strip_escapes():", "\\tHello\\nWorld\\r".strip_escapes())  # Hello World

    # 76. substr(from, len)
    print("substr(7, 5):", s.substr(7, 5))  # World

    # 77. to_ascii()
    print("to_ascii():", s.to_ascii())  # Dạng byte ASCII

    # 78. to_float()
    print("to_float():", "123.45".to_float())  # 123.45

    # 79. to_int()
    print("to_int():", "123".to_int())  # 123

    # 80. to_lower()
    print("to_lower():", s.to_lower())  # hello, world!

    # 81. to_upper()
    print("to_upper():", s.to_upper())  # HELLO, WORLD!

    # 82. to_utf8()
    print("to_utf8():", s.to_utf8())  # Dạng byte UTF-8

    # 83. to_wchar()
    print("to_wchar():", s.to_wchar())  # Dạng wchar

    # 84. trim_prefix(prefix)
    print("trim_prefix('Hel'):", s.trim_prefix("Hel"))  # lo, World!

    # 85. trim_suffix(suffix)
    print("trim_suffix('ld!'):", s.trim_suffix("ld!"))  # Hello, Wo

    # 86. xml_escape()
    print("xml_escape():", "<tag>Hello</tag>".xml_escape())  # <tag>Hello</tag>
