extends Node2D

# Biến lưu CameraFeed mẫu
var camera_feed = null

func _ready():
	# === 1. CameraServer.get_feed_count() - Lấy số lượng camera feed đang có ===
	print("Số lượng camera hiện tại: ", CameraServer.get_feed_count())

	# === 2. CameraServer.feeds() - Lấy toàn bộ danh sách CameraFeed ===
	var feed_list = CameraServer.feeds()
	print("Danh sách camera feeds:")
	for feed in feed_list:
		print(" - ID: ", feed.id)
		print("   Name: ", feed.name)
		print("   Active: ", feed.is_active())
		print("   Camera active: ", feed.is_camera_active())

	# === 3. CameraServer.add_feed(feed) - Thêm một CameraFeed vào server (rất ít dùng trực tiếp) ===
	# Tạo một CameraFeed giả lập (trên nền tảng không hỗ trợ sẽ trả về lỗi)
	camera_feed = CameraFeed.new()


	# === 4. CameraServer.get_feed(index) - Lấy camera feed theo index ===
	if CameraServer.get_feed_count() > 0:
		var first_feed = CameraServer.get_feed(0)
		print("Lấy được camera feed đầu tiên: ", first_feed.name)
	else:
		print("Không có camera feed nào khả dụng.")

	# === 5. CameraServer.remove_feed(feed) - Xóa một camera feed khỏi server ===
	if camera_feed:
		CameraServer.remove_feed(camera_feed)
		print("Đã xóa camera feed  khỏi server")

	# === KẾT NỐI VÀO SIGNAL ===

	# Kết nối signal khi có camera feed mới được thêm
	CameraServer.connect("camera_feed_added", self, "_on_camera_feed_added")
	# Kết nối signal khi có camera feed bị xóa
	CameraServer.connect("camera_feed_removed", self, "_on_camera_feed_removed")

	# === GỢI Ý: Kiểm tra xem có thể truy cập camera hay không ===
	if OS.has_feature("mobile"):
		print("Trên nền tảng di động, hãy yêu cầu quyền trước khi truy cập camera.")
	else:
		print("Chế độ desktop: Chỉ hỗ trợ trên macOS và iOS.")

func _on_camera_feed_added(id):
	print("Có camera mới được thêm, ID: ", id)

func _on_camera_feed_removed(id):
	print("Camera bị gỡ bỏ, ID: ", id)
