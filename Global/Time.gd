extends Node2D

func _ready():
	# === 1. LẤY THỜI GIAN HỆ THỐNG ===

	# 1. Time.get_date_dict_from_system(utc) - Lấy ngày từ hệ thống dưới dạng Dictionary
	var date_dict = Time.get_date_dict_from_system(false)
	print("Ngày (Dictionary): ", date_dict)

	# 2. Time.get_date_string_from_system(utc) - Lấy ngày dưới dạng chuỗi YYYY-MM-DD
	var date_str = Time.get_date_string_from_system(false)
	print("Ngày (chuỗi): ", date_str)

	# 3. Time.get_time_dict_from_system(utc) - Lấy giờ phút giây từ hệ thống
	var time_dict = Time.get_time_dict_from_system(false)
	print("Thời gian (Dictionary): ", time_dict)

	# 4. Time.get_time_string_from_system(utc) - Lấy thời gian dưới dạng HH:MM:SS
	var time_str = Time.get_time_string_from_system(false)
	print("Thời gian (chuỗi): ", time_str)

	# 5. Time.get_datetime_dict_from_system(utc) - Ngày + giờ từ hệ thống
	var datetime_dict = Time.get_datetime_dict_from_system(false)
	print("Ngày giờ (Dictionary): ", datetime_dict)

	# 6. Time.get_datetime_string_from_system(utc, use_space) - Ngày giờ dưới dạng chuỗi
	var datetime_str = Time.get_datetime_string_from_system(false, false)
	print("Ngày giờ (chuỗi): ", datetime_str)

	# === 2. CHUYỂN TỪ UNIX TIME SANG CÁC ĐỊNH DẠNG KHÁC ===

	# 7. Time.get_date_dict_from_unix_time(unix_time) - Từ timestamp sang ngày (dictionary)
	var now_unix = OS.get_unix_time()
	var date_from_unix = Time.get_date_dict_from_unix_time(now_unix)
	print("Unix -> Ngày: ", date_from_unix)

	# 8. Time.get_date_string_from_unix_time(unix_time) - Từ timestamp sang chuỗi ngày
	var date_str_unix = Time.get_date_string_from_unix_time(now_unix)
	print("Unix -> Ngày (chuỗi): ", date_str_unix)

	# 9. Time.get_time_dict_from_unix_time(unix_time) - Từ timestamp sang giờ (dictionary)
	var time_dict_unix = Time.get_time_dict_from_unix_time(now_unix)
	print("Unix -> Thời gian (Dictionary): ", time_dict_unix)

	# 10. Time.get_time_string_from_unix_time(unix_time) - Từ timestamp sang chuỗi giờ
	var time_str_unix = Time.get_time_string_from_unix_time(now_unix)
	print("Unix -> Thời gian (chuỗi): ", time_str_unix)

	# 11. Time.get_datetime_dict_from_unix_time(unix_time) - Từ timestamp sang ngày giờ dict
	var datetime_dict_unix = Time.get_datetime_dict_from_unix_time(now_unix)
	print("Unix -> Ngày giờ (dict): ", datetime_dict_unix)

	# 12. Time.get_datetime_string_from_unix_time(unix_time, use_space) - Từ timestamp sang chuỗi ngày giờ
	var datetime_str_unix = Time.get_datetime_string_from_unix_time(now_unix, false)
	print("Unix -> Ngày giờ (chuỗi): ", datetime_str_unix)

	# === 3. CHUYỂN ĐỔI QUA LẠI VỚI DICTIONARY VÀ CHUỖI ===

	# 13. Time.get_datetime_dict_from_datetime_string(datetime_str, weekday) - Chuỗi -> Dictionary
	var dt_str = "2023-12-25T15:30:45"
	var dt_dict = Time.get_datetime_dict_from_datetime_string(dt_str, true)
	print("Chuỗi -> Ngày giờ (dict): ", dt_dict)

	# 14. Time.get_datetime_string_from_datetime_dict(datetime_dict, use_space) - Dictionary -> Chuỗi
	var dt_str_out = Time.get_datetime_string_from_datetime_dict(dt_dict, false)
	print("Ngày giờ (dict) -> Chuỗi: ", dt_str_out)

	# 15. Time.get_offset_string_from_offset_minutes(offset_minutes) - Offset phút -> chuỗi "+07:00"
	var offset_minutes = 420  # UTC+7
	var offset_str = Time.get_offset_string_from_offset_minutes(offset_minutes)
	print("Offset phút -> chuỗi: ", offset_str)

	# 16. Time.get_time_zone_from_system() - Lấy thông tin múi giờ hệ thống
	var tz_info = Time.get_time_zone_from_system()
	print("Thông tin múi giờ hệ thống: ", tz_info)

	# 17. Time.get_unix_time_from_datetime_dict(datetime_dict) - Dictionary -> Unix timestamp
	var unix_time = Time.get_unix_time_from_datetime_dict(dt_dict)
	print("Ngày giờ (dict) -> Unix: ", unix_time)

	# 18. Time.get_unix_time_from_datetime_string(datetime_str) - Chuỗi -> Unix timestamp
	var unix_time_str = Time.get_unix_time_from_datetime_string(dt_str)
	print("Chuỗi -> Unix: ", unix_time_str)

	# 19. Time.get_unix_time_from_system() - Lấy Unix timestamp chính xác cao (float)
	var unix_now = Time.get_unix_time_from_system()
	print("Lấy Unix hiện tại (float): ", unix_now)

	# === 4. GET TICKS (THỜI GIAN TRÔI KỂ TỪ KHI BẮT ĐẦU GAME) ===

	# 20. Time.get_ticks_msec() - Số mili giây kể từ lúc khởi động
	print("Số mili giây trôi qua: ", Time.get_ticks_msec())

	# 21. Time.get_ticks_usec() - Số micro giây kể từ lúc khởi động
	print("Số micro giây trôi qua: ", Time.get_ticks_usec())
