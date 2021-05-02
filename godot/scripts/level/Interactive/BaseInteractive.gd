extends Area2D
class_name BaseInteractive

var can_interact = false

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		can_interact = true

func _on_Area2D_body_exited(body: Node) -> void:
	if body is Player:
		can_interact = false

func _process(delta: float) -> void:
	var interact_key = Input.is_action_just_pressed("interact")
	if interact_key && can_interact:
		interact()

func interact() -> void:
	print("Key E pressed")
