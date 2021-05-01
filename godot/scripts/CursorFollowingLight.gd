extends Light2D
class_name CursorFollowingLight


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	self.global_position = mouse_pos
