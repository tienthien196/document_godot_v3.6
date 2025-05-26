extends Node

# Hàm _ready() chạy khi đối tượng được thêm vào scene tree
func _ready():
	print("Bắt đầu demo các hàm built-in của GDScript")

	# 🔢 Toán học cơ bản
	var abs_val = abs(-5)
	print("abs(-5) = ", abs_val)  # Trị tuyệt đối
	
	var ceil_val = ceil(2.1)
	print("ceil(2.1) = ", ceil_val)  # Làm tròn lên
	
	var floor_val = floor(2.9)
	print("floor(2.9) = ", floor_val)  # Làm tròn xuống
	
	var round_val = round(2.5)
	print("round(2.5) = ", round_val)  # Làm tròn gần nhất

	var sqrt_val = sqrt(16)
	print("sqrt(16) = ", sqrt_val)  # Căn bậc hai

	var pow_val = pow(2, 3)
	print("pow(2,3) = ", pow_val)  # Lũy thừa

	var sin_val = sin(PI / 2)
	print("sin(PI/2) = ", sin_val)  # Hàm sin

	var cos_val = cos(0)
	print("cos(0) = ", cos_val)  # Hàm cos

	var tan_val = tan(PI / 4)
	print("tan(PI/4) = ", tan_val)  # Hàm tan

	var asin_val = asin(1)
	print("asin(1) = ", rad2deg(asin_val))  # Arcsin + đổi sang độ

	var acos_val = acos(0)
	print("acos(0) = ", rad2deg(acos_val))  # Arccos

	var atan_val = atan(1)
	print("atan(1) = ", rad2deg(atan_val))  # Arctan

	var atan2_val = atan2(1, 1)
	print("atan2(1,1) = ", rad2deg(atan2_val))  # Arctan2 với y/x

	var log_val = log(10)
	print("log(10) = ", log_val)  # Log tự nhiên

	var exp_val = exp(1)
	print("exp(1) = ", exp_val)  # e^x

	var sinh_val = sinh(1)
	print("sinh(1) = ", sinh_val)  # Sin hyperbolic

	var cosh_val = cosh(1)
	print("cosh(1) = ", cosh_val)  # Cos hyperbolic

	var tanh_val = tanh(1)
	print("tanh(1) = ", tanh_val)  # Tan hyperbolic

	var fmod_val = fmod(7, 3)
	print("fmod(7,3) = ", fmod_val)  # Chia lấy dư cho float

	var wrapf_val = wrapf(5, 0, 3)
	print("wrapf(5,0,3) = ", wrapf_val)  # Gấp lại giá trị

	var wrapi_val = wrapi(5, 0, 3)
	print("wrapi(5,0,3) = ", wrapi_val)  # Gấp lại nguyên

	var sign_val = sign(-10)
	print("sign(-10) = ", sign_val)  # Dấu của số

	var max_val = max(5, 10)
	print("max(5,10) = ", max_val)  # Giá trị lớn hơn

	var min_val = min(5, 10)
	print("min(5,10) = ", min_val)  # Giá trị nhỏ hơn

	var clamp_val = clamp(15, 5, 10)
	print("clamp(15,5,10) = ", clamp_val)  # Giới hạn giá trị

	var move_toward_val = move_toward(5, 10, 3)
	print("move_toward(5,10,3) = ", move_toward_val)  # Tiến gần tới

	var lerp_val = lerp(0, 10, 0.5)
	print("lerp(0,10,0.5) = ", lerp_val)  # Nội suy tuyến tính

	var range_lerp_val = range_lerp(75, 0, 100, -1, 1)
	print("range_lerp(75,0,100,-1,1) = ", range_lerp_val)  # Ánh xạ khoảng

	var inverse_lerp_val = inverse_lerp(0, 10, 5)
	print("inverse_lerp(0,10,5) = ", inverse_lerp_val)  # Nghịch đảo nội suy

	var ease_val = ease(0.5, 2)
	print("ease(0.5,2) = ", ease_val)  # Nội suy mượt

	var smoothstep_val = smoothstep(0, 1, 0.5)
	print("smoothstep(0,1,0.5) = ", smoothstep_val)  # Nội suy S-curve

	var deg_to_rad = deg2rad(180)
	print("deg2rad(180) = ", deg_to_rad)  # Đổi độ sang radian

	var rad_to_deg = rad2deg(PI)
	print("rad2deg(PI) = ", rad_to_deg)  # Đổi radian sang độ

	# 🎲 Random & Số ngẫu nhiên
	randomize()
	print("randomize(): Khởi tạo seed ngẫu nhiên")

	var randi_val = randi()
	print("randi() = ", randi_val % 100)  # Ngẫu nhiên từ 0-99

	var randf_val = randf()
	print("randf() = ", randf_val)  # Ngẫu nhiên float [0,1]

	var rand_range_val = rand_range(1, 10)
	print("rand_range(1,10) = ", rand_range_val)  # Ngẫu nhiên trong đoạn

	var seed_val = 12345
	seed(seed_val)
	print("seed(12345): Thiết lập seed cố định")

	var rand_seed_val = rand_seed(67890)
	print("rand_seed(67890) = ", rand_seed_val)  # Tạo số ngẫu nhiên từ seed

	# 🔤 Xử lý chuỗi
	var char_val = char(65)
	print("char(65) = ", char_val)  # Ký tự từ mã ASCII

	var ord_val = ord("A")
	print("ord('A') = ", ord_val)  # Mã ASCII từ ký tự

	var str_val = str(123, "abc", Vector2(1, 2))
	print("str(...) = ", str_val)  # Biến thành chuỗi

	# 🧮 Các hàm tiện ích khác
	var hash_val = hash("hello")
	print("hash('hello') = ", hash_val)  # Băm giá trị

	var len_val = len([1, 2, 3])
	print("len([1,2,3]) = ", len_val)  # Độ dài

	var is_equal_approx_val = is_equal_approx(0.1 + 0.2, 0.3)
	print("is_equal_approx(0.1+0.2,0.3) = ", is_equal_approx_val)  # So sánh gần đúng

	var is_zero_approx_val = is_zero_approx(0.000001)
	print("is_zero_approx(0.000001) = ", is_zero_approx_val)  # Có gần bằng 0?

	var is_nan_val = is_nan(NAN)
	print("is_nan(NAN) = ", is_nan_val)  # Kiểm tra NaN

	var is_inf_val = is_inf(INF)
	print("is_inf(INF) = ", is_inf_val)  # Kiểm tra vô cực

	var deep_equal_val = deep_equal([1, {2: 3}], [1, {2: 3}])
	print("deep_equal(...) = ", deep_equal_val)  # So sánh sâu

	# 🟦 Màu sắc
	var color8 = Color8(255, 0, 0)
	print("Color8(255,0,0) = ", color8)

	var colorN = ColorN("blue")
	print("ColorN('blue') = ", colorN)

	# 📦 Biến đổi dữ liệu
	var array = [1, 2, 3]
	var var2bytes_val = var2bytes(array)
	print("var2bytes([1,2,3]) = ", var2bytes_val)

	var bytes2var_val = bytes2var(var2bytes_val)
	print("bytes2var(...) = ", bytes2var_val)

	var var2str_val = var2str(array)
	print("var2str([1,2,3]) = ", var2str_val)

	var str2var_val = str2var(var2str_val)
	print("str2var(...) = ", str2var_val)

	# 🔄 JSON
	var json = to_json({"name": "Godot", "version": 3.6})
	print("to_json(...) = ", json)

	var parsed = parse_json(json)
	print("parse_json(...) = ", parsed)

	var valid = validate_json(json)
	print("validate_json(...) = ", valid)

	# 📁 Load tài nguyên
	# Giả sử có file res://icon.png tồn tại
	# var icon = load("res://icon.png")
	# print("load('res://icon.png') = ", icon)

	# var preloaded_icon = preload("res://icon.png")
	# print("preload('res://icon.png') = ", preloaded_icon)

	# 📈 Hàm khác
	var nearest_po2_val = nearest_po2(5)
	print("nearest_po2(5) = ", nearest_po2_val)  # Gần power of 2

	var stepify_val = stepify(3.14159, 0.01)
	print("stepify(3.14159,0.01) = ", stepify_val)  # Làm tròn theo bước

	var decimals_val = decimals(0.01)
	print("decimals(0.01) = ", decimals_val)  # Số thập phân sau dấu .

	var step_decimals_val = step_decimals(0.01)
	print("step_decimals(0.01) = ", step_decimals_val)  # Số thập phân bước

	# 📌 In ra stack trace
	print_stack()
	

	print("Kết thúc demo các hàm built-in")
