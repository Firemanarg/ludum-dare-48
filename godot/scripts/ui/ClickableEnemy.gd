extends Sprite
class_name ClickableEnemy

onready var area2d = get_node("Area2D")

func _ready() -> void:
	randomize_coords()
	pass

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			randomize_coords()
	pass

func randomize_coords():
	var screen_size: Vector2 = get_viewport().size
	randomize()
	var rand_x = randi() % int(screen_size.x)
	var rand_y = randi() % int(screen_size.y)
	self.transform.origin = Vector2(rand_x, rand_y)
