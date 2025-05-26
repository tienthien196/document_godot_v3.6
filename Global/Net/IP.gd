extends Node2D

# Biến lưu ID truy vấn DNS
var resolve_id = -1

func _ready():
	# 1. IP.get_local_addresses() - Lấy tất cả địa chỉ IP cục bộ (IPv4 & IPv6)
	var local_addrs = IP.get_local_addresses()
	print("Địa chỉ IP cục bộ: ", local_addrs)

	# 2. IP.get_local_interfaces() - Lấy thông tin các card mạng có sẵn
	var interfaces = IP.get_local_interfaces()
	for interface in interfaces:
		print("Giao diện mạng: ")
		print("  Chỉ số: ", interface["index"])
		print("  Tên giao diện: ", interface["name"])
		print("  Tên thân thiện: ", interface["friendly"])
		print("  Địa chỉ IP: ", interface["addresses"])

	# 3. IP.resolve_hostname("google.com", IP.TYPE_ANY) - Phân giải hostname thành IP (blocking)
	var ip_blocking = IP.resolve_hostname("google.com", IP.TYPE_ANY)
	print("IP của google.com (blocking): ", ip_blocking)

	# 4. IP.resolve_hostname_addresses("godotengine.org", IP.TYPE_IPV4) - Lấy tất cả IP (IPv4 hoặc IPv6)
	var ips = IP.resolve_hostname_addresses("godotengine.org", IP.TYPE_IPV4)
	print("Tất cả IP của godotengine.org (IPv4): ", ips)

	# 5. IP.resolve_hostname_queue_item("example.com") - Bắt đầu phân giải không đồng bộ
	resolve_id = IP.resolve_hostname_queue_item("example.com", IP.TYPE_ANY)
	if resolve_id != IP.RESOLVER_INVALID_ID:
		print("Bắt đầu truy vấn DNS với ID: ", resolve_id)
	else:
		print("Không thể bắt đầu truy vấn DNS.")

	# 6. IP.get_resolve_item_status(resolve_id) - Kiểm tra trạng thái truy vấn
	yield(get_tree().create_timer(1.0), "timeout")  # Chờ một chút để truy vấn xong
	var status = IP.get_resolve_item_status(resolve_id)
	match status:
		IP.RESOLVER_STATUS_NONE:
			print("Trạng thái: NONE")
		IP.RESOLVER_STATUS_WAITING:
			print("Trạng thái: WAITING")
		IP.RESOLVER_STATUS_DONE:
			print("Trạng thái: DONE")
		IP.RESOLVER_STATUS_ERROR:
			print("Trạng thái: ERROR")

	# 7. IP.get_resolve_item_address(resolve_id) - Lấy địa chỉ IP đã phân giải
	var resolved_ip = IP.get_resolve_item_address(resolve_id)
	print("Địa chỉ IP sau khi phân giải: ", resolved_ip)

	# 8. IP.get_resolve_item_addresses(resolve_id) - Lấy tất cả địa chỉ đã phân giải
	var all_resolved_ips = IP.get_resolve_item_addresses(resolve_id)
	print("Tất cả IP được phân giải: ", all_resolved_ips)

	# 9. IP.erase_resolve_item(resolve_id) - Xóa truy vấn khỏi hàng đợi
	IP.erase_resolve_item(resolve_id)
	print("Đã xóa truy vấn với ID: ", resolve_id)

	# 10. IP.clear_cache() - Xóa toàn bộ cache DNS
	IP.clear_cache()
	print("Đã xóa cache DNS.")
