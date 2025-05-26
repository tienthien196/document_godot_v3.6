# Class Performance trong Godot Engine giúp theo dõi hiệu năng hệ thống 
# hoặc tùy chỉnh thêm các chỉ số đo lường riêng (custom monitors).
# Nó hỗ trợ:

# Truy cập các chỉ số built-in như FPS, thời gian frame,...
# Thêm/xóa/kiểm tra các monitor tùy biến.
# Dùng chung với debugger để hiển thị dữ liệu trong Performance Monitor Panel.

extends Node

func _ready():
	# FPS và thời gian frame
	print("FPS hiện tại: ", Performance.get_monitor(Performance.TIME_FPS))
	print("Thời gian xử lý một frame (s): ", Performance.get_monitor(Performance.TIME_PROCESS))
	print("Thời gian xử lý physics (s): ", Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS))

	# Bộ nhớ (debug builds only)
	print("Bộ nhớ tĩnh đang dùng (bytes): ", Performance.get_monitor(Performance.MEMORY_STATIC))
	print("Bộ nhớ động đang dùng (bytes): ", Performance.get_monitor(Performance.MEMORY_DYNAMIC))
	print("Giới hạn bộ nhớ tĩnh (bytes): ", Performance.get_monitor(Performance.MEMORY_STATIC_MAX))
	print("Giới hạn bộ nhớ động (bytes): ", Performance.get_monitor(Performance.MEMORY_DYNAMIC_MAX))
	print("Lượng đỉnh buffer message queue (bytes): ", Performance.get_monitor(Performance.MEMORY_MESSAGE_BUFFER_MAX))

	# Số lượng object & tài nguyên
	print("Số lượng object đang tồn tại: ", Performance.get_monitor(Performance.OBJECT_COUNT))
	print("Số lượng resource đang dùng: ", Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
	print("Số lượng node đang tồn tại: ", Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	print("Số lượng node không có cha (orphan nodes): ", Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT))

	# Render 3D
	print("Số lượng object 3D vẽ mỗi frame: ", Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))
	print("Số lượng vertex 3D vẽ mỗi frame: ", Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))
	print("Thay đổi material mỗi frame: ", Performance.get_monitor(Performance.RENDER_MATERIAL_CHANGES_IN_FRAME))
	print("Thay đổi shader mỗi frame: ", Performance.get_monitor(Performance.RENDER_SHADER_CHANGES_IN_FRAME))
	print("Thay đổi surface render mỗi frame: ", Performance.get_monitor(Performance.RENDER_SURFACE_CHANGES_IN_FRAME))
	print("Số lượng draw calls 3D mỗi frame: ", Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME))

	# Render 2D
	print("Số lượng item 2D vẽ mỗi frame: ", Performance.get_monitor(Performance.RENDER_2D_ITEMS_IN_FRAME))
	print("Số lượng draw calls 2D mỗi frame: ", Performance.get_monitor(Performance.RENDER_2D_DRAW_CALLS_IN_FRAME))

	# Video memory
	print("Tổng video memory đang dùng (texture + vertex): ", Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))
	print("Texture memory đang dùng (bytes): ", Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED))
	print("Vertex memory đang dùng (bytes): ", Performance.get_monitor(Performance.RENDER_VERTEX_MEM_USED))
	print("Tổng video memory khả dụng (GLES2/GLES3 luôn = 0): ", Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL))

	# Vật lý 2D
	print("Số lượng RigidBody2D đang hoạt động: ", Performance.get_monitor(Performance.PHYSICS_2D_ACTIVE_OBJECTS))
	print("Số lượng cặp va chạm 2D: ", Performance.get_monitor(Performance.PHYSICS_2D_COLLISION_PAIRS))
	print("Số lượng islands vật lý 2D: ", Performance.get_monitor(Performance.PHYSICS_2D_ISLAND_COUNT))

	# Vật lý 3D
	print("Số lượng RigidBody/VehicleBody đang hoạt động: ", Performance.get_monitor(Performance.PHYSICS_3D_ACTIVE_OBJECTS))
	print("Số lượng cặp va chạm 3D: ", Performance.get_monitor(Performance.PHYSICS_3D_COLLISION_PAIRS))
	print("Số lượng islands vật lý 3D: ", Performance.get_monitor(Performance.PHYSICS_3D_ISLAND_COUNT))

	# Âm thanh
	print("Độ trễ âm thanh đầu ra (latency): ", Performance.get_monitor(Performance.AUDIO_OUTPUT_LATENCY))


