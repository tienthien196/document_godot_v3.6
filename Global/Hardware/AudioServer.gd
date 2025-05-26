# AudioServer là một singleton cung cấp giao diện truy cập âm thanh ở mức thấp hơn, dùng để:

# Tạo bus âm thanh,
# Thêm/xóa/hiệu chỉnh hiệu ứng âm thanh,
# Lấy danh sách thiết bị âm thanh đang kết nối,
# Điều khiển toàn bộ hệ thống âm thanh trong game hoặc ứng dụng.
# Rất hữu ích khi bạn cần xây dựng hệ thống âm thanh phức tạp, ví dụ như:

# Hệ thống âm thanh riêng cho từng nhóm (buses),
# Hiển thị phân tích âm thanh (spectrum),
# Hoặc xử lý microphone input.

extends Node2D

func _ready():
	# === THUỘC TÍNH (PROPERTIES) ===

	# 1. AudioServer.bus_count = 1
	print("Số lượng bus âm thanh hiện tại: ", AudioServer.get_bus_count())
	
	# 2. AudioServer.capture_device = "Default"
	print("Thiết bị thu âm hiện tại: ", AudioServer.capture_get_device())
	
	# 3. AudioServer.device = "Default"
	print("Thiết bị phát âm thanh hiện tại: ", AudioServer.get_device())

	# 4. AudioServer.global_rate_scale = 1.0
	AudioServer.set_global_rate_scale(1.0)
	print("Tốc độ phát âm thanh toàn cục: ", AudioServer.get_global_rate_scale())

	# === PHƯƠNG THỨC (METHODS) ===

	# 5. AudioServer.add_bus(at_position=-1)
	AudioServer.add_bus()
	print("Đã thêm một bus mới")

	# 6. AudioServer.move_bus(index, to_index)
	if AudioServer.get_bus_count() > 1:
		AudioServer.move_bus(1, 0)
		print("Di chuyển bus từ vị trí 1 sang 0")

	# 7. AudioServer.remove_bus(index)
	if AudioServer.get_bus_count() > 1:
		AudioServer.remove_bus(1)
		print("Đã xóa bus thứ 2")

	# 8. AudioServer.get_bus_name(bus_idx), set_bus_name(bus_idx, name)
	var initial_bus_name = AudioServer.get_bus_name(0)
	print("Tên bus đầu tiên: ", initial_bus_name)

	AudioServer.set_bus_name(0, "Main Bus")
	print("Đổi tên bus thành 'Main Bus'")

	# 9. AudioServer.get_bus_index(String name)
	var main_bus_index = AudioServer.get_bus_index("Main Bus")
	print("Index của 'Main Bus': ", main_bus_index)

	# 10. AudioServer.get_bus_volume_db(bus_idx), set_bus_volume_db(bus_idx, volume_db)
	var current_volume = AudioServer.get_bus_volume_db(0)
	print("Âm lượng bus 0 (dB): ", current_volume)

	AudioServer.set_bus_volume_db(0, -6.0)
	print("Đặt âm lượng về -6 dB")

	# 11. AudioServer.is_bus_mute(bus_idx), set_bus_mute(bus_idx, enable)
	var is_muted = AudioServer.is_bus_mute(0)
	print("Bus có mute không? ", is_muted)

	AudioServer.set_bus_mute(0, false)
	print("Bỏ mute cho bus 0")

	# 12. AudioServer.is_bus_solo(bus_idx), set_bus_solo(bus_idx, enable)
	var is_soloed = AudioServer.is_bus_solo(0)
	print("Bus có solo không? ", is_soloed)

	AudioServer.set_bus_solo(0, false)
	print("Bỏ chế độ solo cho bus 0")

	# 13. AudioServer.is_bus_bypassing_effects(bus_idx), set_bus_bypass_effects(bus_idx, enable)
	var bypass_effect = AudioServer.is_bus_bypassing_effects(0)
	print("Bus bypass hiệu ứng không? ", bypass_effect)

	AudioServer.set_bus_bypass_effects(0, false)
	print("Tắt chế độ bypass hiệu ứng cho bus 0")

	# 14. AudioServer.get_bus_send(bus_idx), set_bus_send(bus_idx, send)
	var send_to = AudioServer.get_bus_send(0)
	print("Bus 0 gửi đến bus nào? ", send_to)

	if AudioServer.get_bus_count() > 1:
		AudioServer.set_bus_send(0, "Main Bus")
		print("Kết nối bus 0 đến Main Bus")

	# 15. AudioServer.get_bus_channels(bus_idx)
	var channels = AudioServer.get_bus_channels(0)
	print("Bus 0 có số kênh: ", channels)

	# 16. AudioServer.get_bus_effect_count(bus_idx)
	var effect_count = AudioServer.get_bus_effect_count(0)
	print("Số lượng hiệu ứng trên bus 0: ", effect_count)

	# 17. AudioServer.add_bus_effect(bus_idx, effect, at_position=-1)
	var reverb = AudioEffectReverb.new()
	reverb.room_size = 0.5
	AudioServer.add_bus_effect(0, reverb)
	print("Thêm hiệu ứng Reverb vào bus 0")

	# 18. AudioServer.get_bus_effect(bus_idx, effect_idx)
	if effect_count < AudioServer.get_bus_effect_count(0):
		var added_effect = AudioServer.get_bus_effect(0, AudioServer.get_bus_effect_count(0) - 1)
		print("Hiệu ứng vừa thêm: ", added_effect)

	# 19. AudioServer.is_bus_effect_enabled(bus_idx, effect_idx), set_bus_effect_enabled(...)
	if AudioServer.get_bus_effect_count(0) > 0:
		var enabled = AudioServer.is_bus_effect_enabled(0, 0)
		print("Hiệu ứng đầu tiên có bật không? ", enabled)

		AudioServer.set_bus_effect_enabled(0, 0, true)
		print("Bật lại hiệu ứng đầu tiên")

	# 20. AudioServer.swap_bus_effects(bus_idx, effect_idx, by_effect_idx)
	if AudioServer.get_bus_effect_count(0) > 1:
		AudioServer.swap_bus_effects(0, 0, 1)
		print("Hoán đổi hai hiệu ứng đầu tiên trong bus 0")

	# 21. AudioServer.remove_bus_effect(bus_idx, effect_idx)
	if AudioServer.get_bus_effect_count(0) > 0:
		AudioServer.remove_bus_effect(0, 0)
		print("Đã xóa hiệu ứng đầu tiên khỏi bus 0")

	# 22. AudioServer.get_bus_effect_instance(bus_idx, effect_idx, channel=0)
	# Cần phải có ít nhất 1 hiệu ứng để lấy instance
	var layout = AudioServer.generate_bus_layout()
	AudioServer.set_bus_layout(layout)
	print("Đã áp dụng bố cục bus mặc định")

	# 23. AudioServer.get_device_list()
	var output_devices = AudioServer.get_device_list()
	print("Danh sách thiết bị âm thanh đầu ra:")
	for dev in output_devices:
		print(" - ", dev)

	# 24. AudioServer.set_device(device)
	if output_devices.size() > 1:
		AudioServer.set_device(output_devices[1])
		print("Chuyển phát âm thanh sang thiết bị đầu ra thứ 2:", output_devices[1])

	# 25. AudioServer.capture_get_device_list()
	var input_devices = AudioServer.capture_get_device_list()
	print("Danh sách thiết bị âm thanh đầu vào:")
	for dev in input_devices:
		print(" - ", dev)

	# 26. AudioServer.capture_set_device(device)
	if input_devices.size() > 1:
		AudioServer.capture_set_device(input_devices[1])
		print("Chuyển thu âm sang thiết bị đầu vào thứ 2:", input_devices[1])

	# 27. AudioServer.get_bus_peak_volume_left_db(bus_idx, channel)
	# Gọi sau mỗi frame nếu muốn lấy giá trị real-time
	yield(get_tree().create_timer(0.1), "timeout")
	var left_peak = AudioServer.get_bus_peak_volume_left_db(0, 0)
	print("Peak trái (bus 0, kênh 0): ", left_peak)

	# 28. AudioServer.get_bus_peak_volume_right_db(bus_idx, channel)
	var right_peak = AudioServer.get_bus_peak_volume_right_db(0, 0)
	print("Peak phải (bus 0, kênh 0): ", right_peak)

	# 29. AudioServer.get_mix_rate()
	var mix_rate = AudioServer.get_mix_rate()
	print("Tần suất trộn âm thanh (mix rate): ", mix_rate, "Hz")

	# 30. AudioServer.get_output_latency()
	var output_latency = AudioServer.get_output_latency()
	print("Độ trễ âm thanh đầu ra: ", output_latency, " giây")

	# 31. AudioServer.get_speaker_mode()
	var speaker_mode = AudioServer.get_speaker_mode()
	match speaker_mode:
		AudioServer.SPEAKER_MODE_STEREO:
			print("Chế độ loa: STEREO (2.0)")
		AudioServer.SPEAKER_SURROUND_31:
			print("Chế độ loa: 3.1 Surround")
		AudioServer.SPEAKER_SURROUND_51:
			print("Chế độ loa: 5.1 Surround")
		AudioServer.SPEAKER_SURROUND_71:
			print("Chế độ loa: 7.1 Surround")

	# 32. AudioServer.lock(), unlock()
	AudioServer.lock()
	print("Đã khóa audio server")

	# => Xử lý điều gì đó an toàn với luồng âm thanh

	AudioServer.unlock()
	print("Đã mở khóa audio server")

	# 33. AudioServer.generate_bus_layout()
	var bus_layout = AudioServer.generate_bus_layout()
	print("Đã tạo bố cục bus âm thanh")

	# 34. AudioServer.set_bus_layout(AudioBusLayout)
	AudioServer.set_bus_layout(bus_layout)
	print("Áp dụng bố cục bus âm thanh")

	# 35. AudioServer.get_time_since_last_mix(), get_time_to_next_mix()
	yield(get_tree().create_timer(0.1), "timeout")
	var time_since_mix = AudioServer.get_time_since_last_mix()
	var time_to_next_mix = AudioServer.get_time_to_next_mix()
	print("Thời gian kể từ lần trộn trước: ", time_since_mix, " giây")
	print("Thời gian đến lần trộn tiếp: ", time_to_next_mix, " giây")
